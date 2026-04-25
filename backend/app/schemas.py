from __future__ import annotations

from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field


class CarProfileSnapshot(BaseModel):
    car_sync_id: str
    display_name: str
    make: str
    model: str
    engine: str
    year: int
    vin: str
    mileage_unit: str
    current_mileage: int


class MaintenanceSummaryItem(BaseModel):
    title: str
    description: str | None = None
    schedule_type: str | None = None
    interval_value: int | None = None
    time_unit: str | None = None


class RepairSummaryItem(BaseModel):
    title: str
    area: str
    status: str
    description: str | None = None


class ManualSummaryItem(BaseModel):
    backend_manual_id: str
    original_name: str


class CarUpsertRequest(BaseModel):
    profile: CarProfileSnapshot


class CarUpsertResponse(BaseModel):
    car_sync_id: str
    vector_store_id: str | None = None


class ManualResponse(BaseModel):
    backend_manual_id: str
    openai_file_id: str
    original_name: str
    byte_size: int
    created_at: datetime


class MaintenanceSuggestion(BaseModel):
    title: str
    description: str
    schedule_type: str
    interval_value: int = Field(ge=1)
    time_unit: str | None = None
    priority: Literal["high", "medium", "low"]
    manual_reference: str | None = None
    selected_by_default: bool = True


class MaintenanceSuggestionsRequest(BaseModel):
    profile: CarProfileSnapshot
    existing_items: list[MaintenanceSummaryItem] = Field(default_factory=list)
    repairs: list[RepairSummaryItem] = Field(default_factory=list)
    manuals: list[ManualSummaryItem] = Field(default_factory=list)


class MaintenanceSuggestionsResponse(BaseModel):
    suggestions: list[MaintenanceSuggestion]


class AssistantSource(BaseModel):
    label: str
    kind: Literal["manual", "web"]
    citation: str | None = None
    url: str | None = None


class AssistantMessageRequest(BaseModel):
    client_id: str = "anonymous"
    local_conversation_id: str | None = None
    conversation_id: str | None = None
    message: str
    profile: CarProfileSnapshot
    maintenance_items: list[MaintenanceSummaryItem] = Field(default_factory=list)
    repairs: list[RepairSummaryItem] = Field(default_factory=list)
    manuals: list[ManualSummaryItem] = Field(default_factory=list)


class AssistantMessageResponse(BaseModel):
    status: Literal["answered", "rejected"]
    conversation_id: str | None = None
    message_id: str
    content: str
    sources: list[AssistantSource] = Field(default_factory=list)
    rejection_reason_code: str | None = None
    used_web_search: bool = False
    used_file_search: bool = False


class ScopeClassification(BaseModel):
    allowed: bool
    reason_code: Literal[
        "about_active_car",
        "generic_automotive",
        "unrelated_topic",
        "safety_blocked",
        "ambiguous_rejected",
    ]
    normalized_scope: str
    confidence: float = Field(ge=0, le=1)


class ChatAnswer(BaseModel):
    conversation_id: str | None = None
    message_id: str
    content: str
    sources: list[AssistantSource] = Field(default_factory=list)
    used_web_search: bool = False
    used_file_search: bool = False


class HealthResponse(BaseModel):
    status: Literal["ok"] = "ok"
