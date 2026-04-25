from __future__ import annotations

from datetime import datetime, timezone

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database import Base


def utcnow() -> datetime:
    return datetime.now(timezone.utc)


class CarRecord(Base):
    __tablename__ = "cars"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    car_sync_id: Mapped[str] = mapped_column(String(64), unique=True, index=True)
    display_name: Mapped[str] = mapped_column(String(255))
    profile_snapshot_json: Mapped[str] = mapped_column(Text)
    vector_store_id: Mapped[str | None] = mapped_column(String(128), nullable=True)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow, onupdate=utcnow
    )

    manuals: Mapped[list[WorkshopManualRecord]] = relationship(
        back_populates="car",
        cascade="all, delete-orphan",
    )
    assistant_session: Mapped[AssistantSessionRecord | None] = relationship(
        back_populates="car",
        cascade="all, delete-orphan",
        uselist=False,
    )
    audit_events: Mapped[list[AssistantAuditEventRecord]] = relationship(
        back_populates="car",
        cascade="all, delete-orphan",
    )


class WorkshopManualRecord(Base):
    __tablename__ = "manuals"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    car_id: Mapped[int] = mapped_column(ForeignKey("cars.id", ondelete="CASCADE"))
    backend_manual_id: Mapped[str] = mapped_column(String(64), unique=True, index=True)
    openai_file_id: Mapped[str] = mapped_column(String(128))
    original_name: Mapped[str] = mapped_column(String(255))
    byte_size: Mapped[int] = mapped_column(Integer)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow
    )
    deleted_at: Mapped[datetime | None] = mapped_column(
        DateTime(timezone=True), nullable=True
    )

    car: Mapped[CarRecord] = relationship(back_populates="manuals")


class AssistantSessionRecord(Base):
    __tablename__ = "assistant_sessions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    car_id: Mapped[int] = mapped_column(
        ForeignKey("cars.id", ondelete="CASCADE"), unique=True
    )
    backend_conversation_id: Mapped[str | None] = mapped_column(
        String(128), nullable=True
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow, onupdate=utcnow
    )

    car: Mapped[CarRecord] = relationship(back_populates="assistant_session")


class AssistantAuditEventRecord(Base):
    __tablename__ = "assistant_audit_events"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    car_id: Mapped[int] = mapped_column(ForeignKey("cars.id", ondelete="CASCADE"))
    client_id: Mapped[str] = mapped_column(String(128))
    allowed: Mapped[bool] = mapped_column(Boolean)
    reason_code: Mapped[str] = mapped_column(String(64))
    normalized_scope: Mapped[str | None] = mapped_column(Text, nullable=True)
    confidence: Mapped[str | None] = mapped_column(String(32), nullable=True)
    raw_message: Mapped[str] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=utcnow
    )

    car: Mapped[CarRecord] = relationship(back_populates="audit_events")
