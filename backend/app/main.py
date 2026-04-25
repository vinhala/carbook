from __future__ import annotations

from fastapi import Depends, FastAPI, File, Form, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from app.config import Settings
from app.database import Base, create_engine_and_session_factory, make_session_dependency
from app.guardrails import InMemoryRateLimiter
from app.openai_client import OpenAIAdapter, OpenAIResponsesAdapter
from app.schemas import (
    AssistantMessageRequest,
    AssistantMessageResponse,
    CarProfileSnapshot,
    CarUpsertRequest,
    CarUpsertResponse,
    HealthResponse,
    MaintenanceSuggestionsRequest,
    MaintenanceSuggestionsResponse,
    ManualResponse,
)
from app.services import CarbookBackendService


def create_app(
    settings: Settings | None = None,
    ai_adapter: OpenAIAdapter | None = None,
) -> FastAPI:
    settings = settings or Settings()
    engine, session_factory = create_engine_and_session_factory(settings)
    Base.metadata.create_all(bind=engine)
    get_db = make_session_dependency(session_factory)
    rate_limiter = InMemoryRateLimiter(
        limit=settings.assistant_rate_limit,
        window_seconds=settings.assistant_rate_window_seconds,
    )
    resolved_adapter = ai_adapter or OpenAIResponsesAdapter(
        api_key=settings.openai_api_key,
        model=settings.openai_model,
        moderation_model=settings.moderation_model,
    )
    service = CarbookBackendService(
        ai_adapter=resolved_adapter,
        rate_limiter=rate_limiter,
    )

    app = FastAPI(title="Carbook Backend", version="0.1.0")
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[settings.carbook_allowed_origin],
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.get("/health", response_model=HealthResponse)
    def health() -> HealthResponse:
        return HealthResponse()

    @app.put("/cars/{car_sync_id}", response_model=CarUpsertResponse)
    def upsert_car(
        car_sync_id: str,
        payload: CarUpsertRequest,
        db: Session = Depends(get_db),
    ) -> CarUpsertResponse:
        return service.upsert_car(db, car_sync_id, payload)

    @app.post("/cars/{car_sync_id}/manuals", response_model=ManualResponse)
    def upload_manual(
        car_sync_id: str,
        profile_json: str = Form(...),
        file: UploadFile = File(...),
        db: Session = Depends(get_db),
    ) -> ManualResponse:
        profile = CarProfileSnapshot.model_validate_json(profile_json)
        return service.upload_manual(db, car_sync_id, profile, file)

    @app.delete("/cars/{car_sync_id}/manuals/{manual_id}", status_code=204)
    def delete_manual(
        car_sync_id: str,
        manual_id: str,
        profile: CarUpsertRequest,
        db: Session = Depends(get_db),
    ) -> None:
        service.delete_manual(db, car_sync_id, manual_id, profile.profile)

    @app.post(
        "/cars/{car_sync_id}/maintenance-suggestions",
        response_model=MaintenanceSuggestionsResponse,
    )
    def maintenance_suggestions(
        car_sync_id: str,
        payload: MaintenanceSuggestionsRequest,
        db: Session = Depends(get_db),
    ) -> MaintenanceSuggestionsResponse:
        return service.generate_maintenance_suggestions(db, car_sync_id, payload)

    @app.post(
        "/cars/{car_sync_id}/assistant/messages",
        response_model=AssistantMessageResponse,
    )
    def assistant_message(
        car_sync_id: str,
        payload: AssistantMessageRequest,
        db: Session = Depends(get_db),
    ) -> AssistantMessageResponse:
        return service.answer_assistant_message(db, car_sync_id, payload)

    return app


app = create_app()
