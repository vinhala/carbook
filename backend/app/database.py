from collections.abc import Generator

from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, Session, sessionmaker
from sqlalchemy.pool import StaticPool

from app.config import Settings


class Base(DeclarativeBase):
    pass


def create_engine_and_session_factory(settings: Settings):
    connect_args = {}
    engine_kwargs = {}
    if settings.carful_database_url.startswith("sqlite"):
        connect_args["check_same_thread"] = False
        if ":memory:" in settings.carful_database_url:
            engine_kwargs["poolclass"] = StaticPool

    engine = create_engine(
        settings.carful_database_url,
        connect_args=connect_args,
        **engine_kwargs,
    )
    session_factory = sessionmaker(
        bind=engine,
        autoflush=False,
        autocommit=False,
        expire_on_commit=False,
        class_=Session,
    )
    return engine, session_factory


def make_session_dependency(session_factory):
    def get_db() -> Generator[Session, None, None]:
        session = session_factory()
        try:
            yield session
        finally:
            session.close()

    return get_db
