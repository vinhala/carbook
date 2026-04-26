from __future__ import annotations

import json
import re
import uuid
from typing import Any, Iterable, Protocol
from urllib.parse import urlparse

from openai import OpenAI

from app.schemas import (
    AssistantMessageRequest,
    AssistantSource,
    ChatAnswer,
    MaintenanceSuggestionsRequest,
    MaintenanceSuggestionsResponse,
    ManualSummaryItem,
    ScopeClassification,
)

_HOSTED_CITATION_PATTERN = re.compile(
    r"\ue200\s*cite(?:\ue202[^\ue201]*)?\ue201"
    r"|【\s*[^】]*(?:file|cite|turn\d+file\d+)[^】]*】"
    r"|Ofilecite\s*\?[^?]*\?"
    r"|(?:\?turn\w*file\d+\s*)+",
    re.IGNORECASE,
)
_PRIVATE_USE_PATTERN = re.compile(r"[\ue000-\uf8ff]+")


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
            "Decide whether the user request is about cars, vehicles, automotive "
            "maintenance, repairs, parts, ownership, buying, diagnostics, manuals, "
            "or modifications. Allow generic automotive requests even when they are "
            "not tied to the active car. Reject only non-automotive requests or "
            "clearly unsafe automotive requests. Return compact JSON "
            "with keys allowed, reason_code, normalized_scope, confidence. "
            "reason_code must be exactly one of: about_active_car, "
            "generic_automotive, unrelated_topic, safety_blocked, "
            "ambiguous_rejected. Use about_active_car when the request is about "
            "the active car, generic_automotive for other car-realm requests, "
            "unrelated_topic for non-automotive requests, safety_blocked for "
            "unsafe requests, and ambiguous_rejected only when the topic cannot "
            "be determined."
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
            "Answer car and automotive questions. When the request appears related "
            "to the active car, use its profile, repairs, maintenance, and manuals "
            "first. For broader automotive questions, give general guidance and use "
            "web results when needed. Prefer manual-backed answers when available "
            "and cite sources briefly."
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
            content=_extract_response_text(response),
            sources=_extract_response_sources(response),
            used_web_search=_response_used_tool(response, "web_search_call"),
            used_file_search=_response_used_tool(response, "file_search_call"),
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


def _extract_response_text(response: Any) -> str:
    text_parts: list[str] = []
    for content in _iter_output_text_content(response):
        text = _get(content, "text")
        if isinstance(text, str):
            for annotation in _as_list(_get(content, "annotations")):
                annotation_text = _get(annotation, "text")
                if (
                    isinstance(annotation_text, str)
                    and annotation_text
                    and _looks_like_citation_artifact(annotation_text)
                ):
                    text = text.replace(annotation_text, "")
            text_parts.append(text)

    raw_text = "\n".join(part for part in text_parts if part).strip()
    if not raw_text:
        raw_text = str(_get(response, "output_text", "") or "")
    return _clean_citation_artifacts(raw_text)


def _extract_response_sources(response: Any) -> list[AssistantSource]:
    sources: list[AssistantSource] = []
    seen: set[tuple[str, str | None, str | None, str]] = set()

    def add(source: AssistantSource) -> None:
        label = source.label.strip()
        if not label:
            return
        normalized = source.model_copy(update={"label": label})
        key = (
            normalized.kind,
            normalized.source_id or normalized.url,
            normalized.citation,
            normalized.label,
        )
        if key in seen:
            return
        seen.add(key)
        sources.append(normalized)

    for content in _iter_output_text_content(response):
        for annotation in _as_list(_get(content, "annotations")):
            source = _source_from_annotation(annotation)
            if source is not None:
                add(source)

    has_manual_source = any(source.kind == "manual" for source in sources)
    has_web_source = any(source.kind == "web" for source in sources)
    for item in _as_list(_get(response, "output")):
        item_type = _get(item, "type")
        if item_type == "file_search_call" and not has_manual_source:
            for result in _as_list(_get(item, "results")):
                source = _manual_source_from_file_result(result)
                if source is not None:
                    add(source)
        elif item_type == "web_search_call" and not has_web_source:
            action = _get(item, "action")
            for result in _as_list(_get(action, "sources")):
                source = _web_source_from_result(result)
                if source is not None:
                    add(source)

    return sources


def _iter_output_text_content(response: Any) -> Iterable[Any]:
    for item in _as_list(_get(response, "output")):
        if _get(item, "type") != "message":
            continue
        for content in _as_list(_get(item, "content")):
            if _get(content, "type") == "output_text":
                yield content


def _source_from_annotation(annotation: Any) -> AssistantSource | None:
    annotation_type = _get(annotation, "type")
    if annotation_type in {"file_citation", "file_path"}:
        return AssistantSource(
            label=_first_str(
                _get(annotation, "filename"),
                _get(annotation, "file_name"),
                _get(annotation, "title"),
                _get(annotation, "file_id"),
            )
            or "Manual",
            kind="manual",
            citation=_first_str(
                _get(annotation, "page"),
                _get(annotation, "locator"),
                _get(annotation, "index"),
            ),
            source_id=_first_str(_get(annotation, "file_id")),
            quote=_first_str(_get(annotation, "quote")),
        )

    if annotation_type in {"url_citation", "web_citation"}:
        url = _first_str(_get(annotation, "url"))
        return AssistantSource(
            label=_first_str(_get(annotation, "title"), _domain_from_url(url)) or "Web",
            kind="web",
            citation=_first_str(_get(annotation, "snippet"), _get(annotation, "quote")),
            url=url,
            source_id=url,
        )

    return None


def _manual_source_from_file_result(result: Any) -> AssistantSource | None:
    label = _first_str(
        _get(result, "filename"),
        _get(result, "file_name"),
        _get(result, "title"),
        _get(result, "file_id"),
    )
    if label is None:
        return None
    return AssistantSource(
        label=label,
        kind="manual",
        citation=_first_str(_get(result, "page"), _get(result, "locator")),
        source_id=_first_str(_get(result, "file_id")),
        quote=_result_quote(result),
    )


def _web_source_from_result(result: Any) -> AssistantSource | None:
    url = _first_str(_get(result, "url"))
    label = _first_str(_get(result, "title"), _domain_from_url(url))
    if label is None and url is None:
        return None
    return AssistantSource(
        label=label or "Web",
        kind="web",
        citation=_first_str(_get(result, "snippet"), _get(result, "text")),
        url=url,
        source_id=url,
    )


def _response_used_tool(response: Any, tool_type: str) -> bool:
    return any(
        _get(item, "type") == tool_type for item in _as_list(_get(response, "output"))
    )


def _clean_citation_artifacts(text: str) -> str:
    cleaned = _HOSTED_CITATION_PATTERN.sub("", text)
    cleaned = _PRIVATE_USE_PATTERN.sub("", cleaned)
    cleaned = re.sub(r"[ \t]+\n", "\n", cleaned)
    cleaned = re.sub(r"\n{3,}", "\n\n", cleaned)
    cleaned = re.sub(r" {2,}", " ", cleaned)
    cleaned = re.sub(r"\s+([,.;:!?])", r"\1", cleaned)
    return cleaned.strip()


def _looks_like_citation_artifact(text: str) -> bool:
    return bool(
        _HOSTED_CITATION_PATTERN.search(text) or _PRIVATE_USE_PATTERN.search(text)
    )


def _result_quote(result: Any) -> str | None:
    content = _get(result, "content")
    if isinstance(content, list):
        chunks = [
            str(_get(chunk, "text"))
            for chunk in content
            if _get(chunk, "text") is not None
        ]
        return " ".join(chunks).strip() or None
    return _first_str(content, _get(result, "text"), _get(result, "snippet"))


def _domain_from_url(url: str | None) -> str | None:
    if not url:
        return None
    parsed = urlparse(url)
    return parsed.netloc or None


def _first_str(*values: Any) -> str | None:
    for value in values:
        if value is None:
            continue
        text = str(value).strip()
        if text:
            return text
    return None


def _as_list(value: Any) -> list[Any]:
    if value is None:
        return []
    if isinstance(value, list):
        return value
    return list(value) if isinstance(value, tuple) else [value]


def _get(value: Any, key: str) -> Any:
    if isinstance(value, dict):
        return value.get(key)
    return getattr(value, key, None)
