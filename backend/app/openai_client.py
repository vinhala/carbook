from __future__ import annotations

import json
import uuid
from typing import Protocol

from openai import OpenAI

from app.schemas import (
    AssistantMessageRequest,
    ChatAnswer,
    MaintenanceSuggestionsRequest,
    MaintenanceSuggestionsResponse,
    ManualSummaryItem,
    ScopeClassification,
)


class OpenAIAdapter(Protocol):
    def moderate_text(self, text: str) -> bool: ...

    def create_vector_store(self, display_name: str) -> str: ...

    def upload_manual(self, filename: str, content: bytes) -> str: ...

    def attach_file_to_vector_store(self, vector_store_id: str, file_id: str) -> None: ...

    def delete_file(self, file_id: str) -> None: ...

    def delete_vector_store_file(self, vector_store_id: str, file_id: str) -> None: ...

    def classify_scope(self, payload: AssistantMessageRequest) -> ScopeClassification: ...

    def generate_maintenance_suggestions(
        self,
        payload: MaintenanceSuggestionsRequest,
        vector_store_id: str,
    ) -> MaintenanceSuggestionsResponse: ...

    def answer_chat(
        self,
        payload: AssistantMessageRequest,
        vector_store_id: str,
        persisted_conversation_id: str | None,
    ) -> ChatAnswer: ...


class OpenAIResponsesAdapter:
    def __init__(self, api_key: str, model: str, moderation_model: str) -> None:
        self._client = OpenAI(api_key=api_key)
        self._model = model
        self._moderation_model = moderation_model

    def moderate_text(self, text: str) -> bool:
        response = self._client.moderations.create(
            model=self._moderation_model,
            input=text,
        )
        return bool(response.results[0].flagged)

    def create_vector_store(self, display_name: str) -> str:
        result = self._client.vector_stores.create(name=f"{display_name} manuals")
        return result.id

    def upload_manual(self, filename: str, content: bytes) -> str:
        uploaded = self._client.files.create(
            file=(filename, content),
            purpose="assistants",
        )
        return uploaded.id

    def attach_file_to_vector_store(self, vector_store_id: str, file_id: str) -> None:
        self._client.vector_stores.files.create(
            vector_store_id=vector_store_id,
            file_id=file_id,
        )

    def delete_file(self, file_id: str) -> None:
        self._client.files.delete(file_id)

    def delete_vector_store_file(self, vector_store_id: str, file_id: str) -> None:
        try:
            self._client.vector_stores.files.delete(
                vector_store_id=vector_store_id,
                file_id=file_id,
            )
        except Exception:
            return

    def classify_scope(self, payload: AssistantMessageRequest) -> ScopeClassification:
        prompt = (
            "Decide whether the user request is specifically about the currently "
            "selected car or work on that car. Reject generic automotive requests "
            "unless they are clearly tied to the active car. Return compact JSON "
            "with keys allowed, reason_code, normalized_scope, confidence."
        )
        input_payload = {
            "profile": payload.profile.model_dump(),
            "manuals": [manual.model_dump() for manual in payload.manuals],
            "maintenance_items": [
                item.model_dump() for item in payload.maintenance_items
            ],
            "repairs": [repair.model_dump() for repair in payload.repairs],
            "message": payload.message,
        }
        response = self._client.responses.create(
            model=self._model,
            input=[
                {"role": "system", "content": prompt},
                {"role": "user", "content": json.dumps(input_payload)},
            ],
        )
        return ScopeClassification.model_validate_json(response.output_text)

    def generate_maintenance_suggestions(
        self,
        payload: MaintenanceSuggestionsRequest,
        vector_store_id: str,
    ) -> MaintenanceSuggestionsResponse:
        prompt = (
            "Generate maintenance schedule suggestions for the active car based on "
            "the uploaded manuals. Return JSON with a top-level suggestions array. "
            "Each suggestion must include title, description, schedule_type, "
            "interval_value, time_unit, priority, manual_reference, and "
            "selected_by_default. Do not repeat existing maintenance items."
        )
        response = self._client.responses.create(
            model=self._model,
            input=[
                {"role": "system", "content": prompt},
                {"role": "user", "content": json.dumps(payload.model_dump())},
            ],
            tools=[
                {
                    "type": "file_search",
                    "vector_store_ids": [vector_store_id],
                }
            ],
        )
        return MaintenanceSuggestionsResponse.model_validate_json(response.output_text)

    def answer_chat(
        self,
        payload: AssistantMessageRequest,
        vector_store_id: str,
        persisted_conversation_id: str | None,
    ) -> ChatAnswer:
        prompt = (
            "Answer only about the active car using its profile, repairs, maintenance, "
            "manuals, and web results when needed. Prefer manual-backed answers and "
            "cite sources briefly."
        )
        response = self._client.responses.create(
            model=self._model,
            conversation=persisted_conversation_id,
            input=[
                {"role": "system", "content": prompt},
                {
                    "role": "user",
                    "content": json.dumps(
                        {
                            "profile": payload.profile.model_dump(),
                            "maintenance_items": [
                                item.model_dump() for item in payload.maintenance_items
                            ],
                            "repairs": [
                                repair.model_dump() for repair in payload.repairs
                            ],
                            "manuals": [manual.model_dump() for manual in payload.manuals],
                            "message": payload.message,
                        }
                    ),
                },
            ],
            tools=[
                {
                    "type": "file_search",
                    "vector_store_ids": [vector_store_id],
                },
                {
                    "type": "web_search",
                },
            ],
            include=["file_search_call.results", "web_search_call.action.sources"],
        )
        return ChatAnswer(
            conversation_id=getattr(response, "conversation", None),
            message_id=getattr(response, "id", f"msg_{uuid.uuid4().hex}"),
            content=response.output_text,
            sources=[],
            used_web_search=True,
            used_file_search=True,
        )


class FakeOpenAIAdapter:
    def __init__(self) -> None:
        self.vector_stores_created: list[str] = []
        self.uploaded_files: list[str] = []
        self.attached_files: list[tuple[str, str]] = []
        self.deleted_files: list[str] = []
        self.deleted_vector_store_files: list[tuple[str, str]] = []
        self.chat_calls = 0
        self.suggestion_calls = 0
        self.scope_calls = 0
        self.moderation_calls: list[str] = []
        self.flag_next_moderation = False
        self.next_scope = ScopeClassification(
            allowed=False,
            reason_code="ambiguous_rejected",
            normalized_scope="ambiguous",
            confidence=0.5,
        )
        self.next_suggestions = MaintenanceSuggestionsResponse(suggestions=[])
        self.next_chat = ChatAnswer(
            conversation_id="conv_test",
            message_id="msg_test",
            content="Test answer",
            sources=[],
            used_file_search=True,
            used_web_search=True,
        )

    def moderate_text(self, text: str) -> bool:
        self.moderation_calls.append(text)
        flagged = self.flag_next_moderation
        self.flag_next_moderation = False
        return flagged

    def create_vector_store(self, display_name: str) -> str:
        vector_store_id = f"vs_{len(self.vector_stores_created) + 1}"
        self.vector_stores_created.append(display_name)
        return vector_store_id

    def upload_manual(self, filename: str, content: bytes) -> str:
        file_id = f"file_{len(self.uploaded_files) + 1}"
        self.uploaded_files.append(filename)
        return file_id

    def attach_file_to_vector_store(self, vector_store_id: str, file_id: str) -> None:
        self.attached_files.append((vector_store_id, file_id))

    def delete_file(self, file_id: str) -> None:
        self.deleted_files.append(file_id)

    def delete_vector_store_file(self, vector_store_id: str, file_id: str) -> None:
        self.deleted_vector_store_files.append((vector_store_id, file_id))

    def classify_scope(self, payload: AssistantMessageRequest) -> ScopeClassification:
        self.scope_calls += 1
        return self.next_scope

    def generate_maintenance_suggestions(
        self,
        payload: MaintenanceSuggestionsRequest,
        vector_store_id: str,
    ) -> MaintenanceSuggestionsResponse:
        self.suggestion_calls += 1
        return self.next_suggestions

    def answer_chat(
        self,
        payload: AssistantMessageRequest,
        vector_store_id: str,
        persisted_conversation_id: str | None,
    ) -> ChatAnswer:
        self.chat_calls += 1
        return self.next_chat
