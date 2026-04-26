from __future__ import annotations

import json
import uuid
from datetime import datetime, timezone

from fastapi import HTTPException, UploadFile
from sqlalchemy.orm import Session

from app.guardrails import InMemoryRateLimiter, deterministic_scope_check
from app.models import (
    AssistantAuditEventRecord,
    AssistantSessionRecord,
    CarRecord,
    WorkshopManualRecord,
)
from app.openai_client import OpenAIAdapter
from app.schemas import (
    AssistantMessageRequest,
    AssistantMessageResponse,
    CarProfileSnapshot,
    CarUpsertRequest,
    CarUpsertResponse,
    ChatAnswer,
    MaintenanceSuggestionsRequest,
    MaintenanceSuggestionsResponse,
    ManualResponse,
    ScopeClassification,
)


def _utcnow() -> datetime:
    return datetime.now(timezone.utc)


class CarfulBackendService:
    def __init__(
        self,
        ai_adapter: OpenAIAdapter,
        rate_limiter: InMemoryRateLimiter,
    ) -> None:
        self._ai_adapter = ai_adapter
        self._rate_limiter = rate_limiter

    def upsert_car(
        self,
        db: Session,
        car_sync_id: str,
        payload: CarUpsertRequest,
    ) -> CarUpsertResponse:
        if car_sync_id != payload.profile.car_sync_id:
            raise HTTPException(status_code=400, detail="car_sync_id mismatch")

        record = db.query(CarRecord).filter_by(car_sync_id=car_sync_id).one_or_none()
        snapshot_json = json.dumps(payload.profile.model_dump())
        if record is None:
            record = CarRecord(
                car_sync_id=car_sync_id,
                display_name=payload.profile.display_name,
                profile_snapshot_json=snapshot_json,
            )
            db.add(record)
        else:
            record.display_name = payload.profile.display_name
            record.profile_snapshot_json = snapshot_json
            record.updated_at = _utcnow()

        db.commit()
        db.refresh(record)
        return CarUpsertResponse(
            car_sync_id=record.car_sync_id,
            vector_store_id=record.vector_store_id,
        )

    def upload_manual(
        self,
        db: Session,
        car_sync_id: str,
        profile: CarProfileSnapshot,
        upload: UploadFile,
    ) -> ManualResponse:
        if not upload.filename or not upload.filename.lower().endswith(".pdf"):
            raise HTTPException(status_code=400, detail="Only PDF manuals are supported")

        car = self._require_car(db, car_sync_id, profile)
        if not car.vector_store_id:
            car.vector_store_id = self._ai_adapter.create_vector_store(profile.display_name)

        content = upload.file.read()
        openai_file_id = self._ai_adapter.upload_manual(upload.filename, content)
        self._ai_adapter.attach_file_to_vector_store(car.vector_store_id, openai_file_id)

        record = WorkshopManualRecord(
            car_id=car.id,
            backend_manual_id=f"manual_{uuid.uuid4().hex[:12]}",
            openai_file_id=openai_file_id,
            original_name=upload.filename,
            byte_size=len(content),
        )
        db.add(record)
        db.commit()
        db.refresh(record)
        db.refresh(car)
        return ManualResponse(
            backend_manual_id=record.backend_manual_id,
            openai_file_id=record.openai_file_id,
            original_name=record.original_name,
            byte_size=record.byte_size,
            created_at=record.created_at,
        )

    def delete_manual(
        self,
        db: Session,
        car_sync_id: str,
        manual_id: str,
        profile: CarProfileSnapshot,
    ) -> None:
        car = self._require_car(db, car_sync_id, profile)
        manual = (
            db.query(WorkshopManualRecord)
            .filter_by(car_id=car.id, backend_manual_id=manual_id, deleted_at=None)
            .one_or_none()
        )
        if manual is None:
            raise HTTPException(status_code=404, detail="Manual not found")

        if car.vector_store_id:
            self._ai_adapter.delete_vector_store_file(car.vector_store_id, manual.openai_file_id)
        self._ai_adapter.delete_file(manual.openai_file_id)
        manual.deleted_at = _utcnow()
        db.commit()

    def generate_maintenance_suggestions(
        self,
        db: Session,
        car_sync_id: str,
        payload: MaintenanceSuggestionsRequest,
    ) -> MaintenanceSuggestionsResponse:
        car = self._require_car(db, car_sync_id, payload.profile)
        if not car.vector_store_id:
            raise HTTPException(status_code=400, detail="Upload workshop manuals first")
        return self._ai_adapter.generate_maintenance_suggestions(
            payload=payload,
            vector_store_id=car.vector_store_id,
        )

    def answer_assistant_message(
        self,
        db: Session,
        car_sync_id: str,
        payload: AssistantMessageRequest,
    ) -> AssistantMessageResponse:
        if not self._rate_limiter.check(payload.client_id or car_sync_id):
            raise HTTPException(status_code=429, detail="Too many assistant requests")

        car = self._require_car(db, car_sync_id, payload.profile)
        if not car.vector_store_id:
            raise HTTPException(status_code=400, detail="Upload workshop manuals first")

        decision = deterministic_scope_check(payload)
        if decision is None:
            decision = self._ai_adapter.classify_scope(payload)

        self._log_audit(db, car.id, payload.client_id, payload.message, decision)

        if not decision.allowed:
            return self._build_rejection_response(decision, payload.conversation_id)

        session = (
            db.query(AssistantSessionRecord)
            .filter_by(car_id=car.id)
            .one_or_none()
        )
        if session is None:
            session = AssistantSessionRecord(car_id=car.id)
            db.add(session)
            db.flush()

        answer = self._ai_adapter.answer_chat(
            payload=payload,
            vector_store_id=car.vector_store_id,
            persisted_conversation_id=session.backend_conversation_id
            or payload.conversation_id,
        )
        session.backend_conversation_id = answer.conversation_id
        session.updated_at = _utcnow()
        db.commit()
        return AssistantMessageResponse(
            status="answered",
            conversation_id=answer.conversation_id,
            message_id=answer.message_id,
            content=answer.content,
            sources=answer.sources,
            used_file_search=answer.used_file_search,
            used_web_search=answer.used_web_search,
        )

    def _require_car(
        self,
        db: Session,
        car_sync_id: str,
        profile: CarProfileSnapshot,
    ) -> CarRecord:
        record = db.query(CarRecord).filter_by(car_sync_id=car_sync_id).one_or_none()
        if record is None:
            record = CarRecord(
                car_sync_id=car_sync_id,
                display_name=profile.display_name,
                profile_snapshot_json=json.dumps(profile.model_dump()),
            )
            db.add(record)
            db.commit()
            db.refresh(record)
        return record

    def _log_audit(
        self,
        db: Session,
        car_id: int,
        client_id: str,
        message: str,
        decision: ScopeClassification,
    ) -> None:
        db.add(
            AssistantAuditEventRecord(
                car_id=car_id,
                client_id=client_id,
                allowed=decision.allowed,
                reason_code=decision.reason_code,
                normalized_scope=decision.normalized_scope,
                confidence=f"{decision.confidence:.2f}",
                raw_message=message,
            )
        )
        db.commit()

    def _build_rejection_response(
        self,
        decision: ScopeClassification,
        conversation_id: str | None,
    ) -> AssistantMessageResponse:
        return AssistantMessageResponse(
            status="rejected",
            conversation_id=conversation_id,
            message_id=f"reject_{uuid.uuid4().hex[:12]}",
            content=(
                "Carful AI can only answer questions about this vehicle and its "
                "maintenance, repairs, manuals, or troubleshooting."
            ),
            rejection_reason_code=decision.reason_code,
            used_file_search=False,
            used_web_search=False,
        )
