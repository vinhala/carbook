from io import BytesIO

from fastapi.testclient import TestClient

from app.config import Settings
from app.main import create_app
from app.openai_client import FakeOpenAIAdapter
from app.schemas import (
    AssistantMessageRequest,
    AssistantSource,
    CarProfileSnapshot,
    ChatAnswer,
    MaintenanceSuggestion,
    MaintenanceSuggestionsResponse,
    ScopeClassification,
)


def build_profile() -> dict:
    return {
        "car_sync_id": "car_sync_1",
        "display_name": "Toyota Tacoma",
        "make": "Toyota",
        "model": "Tacoma",
        "engine": "3.5L V6",
        "year": 2018,
        "vin": "JT123",
        "mileage_unit": "mi",
        "current_mileage": 65000,
    }


def build_chat_payload(message: str, conversation_id: str | None = None) -> dict:
    return {
        "client_id": "device-1",
        "conversation_id": conversation_id,
        "message": message,
        "profile": build_profile(),
        "maintenance_items": [
            {
                "title": "Oil Change",
                "description": "Engine oil and filter",
                "schedule_type": "distance",
                "interval_value": 5000,
                "time_unit": None,
            }
        ],
        "repairs": [
            {
                "title": "Front differential seal",
                "area": "engine",
                "status": "planned",
                "description": "small seep",
            }
        ],
        "manuals": [
            {
                "backend_manual_id": "manual_1",
                "original_name": "Tacoma Service Manual.pdf",
            }
        ],
    }


def create_client():
    settings = Settings(
        openai_api_key="test",
        carbook_database_url="sqlite+pysqlite:///:memory:",
        assistant_rate_limit=50,
    )
    adapter = FakeOpenAIAdapter()
    app = create_app(settings=settings, ai_adapter=adapter)
    return TestClient(app), adapter


def ensure_car_and_manual(client: TestClient) -> None:
    client.put("/cars/car_sync_1", json={"profile": build_profile()})
    client.post(
        "/cars/car_sync_1/manuals",
        data={"profile_json": CarProfileSnapshot(**build_profile()).model_dump_json()},
        files={"file": ("manual.pdf", BytesIO(b"%PDF"), "application/pdf")},
    )


def test_healthcheck():
    client, _ = create_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_manual_upload_creates_vector_store_once():
    client, adapter = create_client()
    client.put("/cars/car_sync_1", json={"profile": build_profile()})

    first = client.post(
        "/cars/car_sync_1/manuals",
        data={"profile_json": CarProfileSnapshot(**build_profile()).model_dump_json()},
        files={"file": ("manual.pdf", BytesIO(b"%PDF"), "application/pdf")},
    )
    second = client.post(
        "/cars/car_sync_1/manuals",
        data={"profile_json": CarProfileSnapshot(**build_profile()).model_dump_json()},
        files={"file": ("manual-2.pdf", BytesIO(b"%PDF-2"), "application/pdf")},
    )

    assert first.status_code == 200
    assert second.status_code == 200
    assert len(adapter.vector_stores_created) == 1
    assert len(adapter.attached_files) == 2


def test_generate_maintenance_suggestions_returns_adapter_payload():
    client, adapter = create_client()
    ensure_car_and_manual(client)
    adapter.next_suggestions = MaintenanceSuggestionsResponse(
        suggestions=[
            MaintenanceSuggestion(
                title="Coolant Flush",
                description="Replace coolant",
                schedule_type="distance",
                interval_value=60000,
                priority="medium",
                manual_reference="Manual Pg. 88",
                selected_by_default=True,
            )
        ]
    )

    response = client.post(
        "/cars/car_sync_1/maintenance-suggestions",
        json={
            "profile": build_profile(),
            "existing_items": [],
            "repairs": [],
            "manuals": [],
        },
    )

    assert response.status_code == 200
    assert response.json()["suggestions"][0]["title"] == "Coolant Flush"
    assert adapter.suggestion_calls == 1


def test_chat_rejects_off_topic_without_main_response_call():
    client, adapter = create_client()
    ensure_car_and_manual(client)

    response = client.post(
        "/cars/car_sync_1/assistant/messages",
        json=build_chat_payload("How do I make lasagna?"),
    )

    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "rejected"
    assert body["rejection_reason_code"] == "unrelated_topic"
    assert adapter.chat_calls == 0


def test_chat_rejects_other_vehicle_reference():
    client, adapter = create_client()
    ensure_car_and_manual(client)

    response = client.post(
        "/cars/car_sync_1/assistant/messages",
        json=build_chat_payload("What oil should a BMW M3 use?"),
    )

    assert response.status_code == 200
    assert response.json()["status"] == "rejected"
    assert adapter.chat_calls == 0


def test_chat_blocks_moderated_content():
    client, adapter = create_client()
    ensure_car_and_manual(client)
    adapter.flag_next_moderation = True

    response = client.post(
        "/cars/car_sync_1/assistant/messages",
        json=build_chat_payload("I want violent instructions"),
    )

    assert response.status_code == 200
    assert response.json()["rejection_reason_code"] == "safety_blocked"
    assert adapter.chat_calls == 0


def test_chat_uses_classifier_for_ambiguous_message():
    client, adapter = create_client()
    ensure_car_and_manual(client)
    adapter.next_scope = ScopeClassification(
        allowed=False,
        reason_code="generic_automotive",
        normalized_scope="generic oil advice",
        confidence=0.81,
    )

    response = client.post(
        "/cars/car_sync_1/assistant/messages",
        json=build_chat_payload("What oil should I use?"),
    )

    assert response.status_code == 200
    assert response.json()["status"] == "rejected"
    assert adapter.scope_calls == 1
    assert adapter.chat_calls == 0


def test_chat_accepts_in_scope_question_and_persists_conversation():
    client, adapter = create_client()
    ensure_car_and_manual(client)
    adapter.next_chat = ChatAnswer(
        conversation_id="conv_live",
        message_id="msg_live",
        content="Use SAE 0W-20 for this Tacoma.",
        sources=[
            AssistantSource(
                label="Tacoma Manual",
                kind="manual",
                citation="Manual Pg. 142",
            )
        ],
        used_file_search=True,
        used_web_search=True,
    )

    response = client.post(
        "/cars/car_sync_1/assistant/messages",
        json=build_chat_payload("What oil should a 2018 Tacoma use?"),
    )

    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "answered"
    assert body["conversation_id"] == "conv_live"
    assert body["sources"][0]["kind"] == "manual"
    assert adapter.chat_calls == 1
