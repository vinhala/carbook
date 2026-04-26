from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    openai_api_key: str = ""
    openai_model: str = "gpt-5.4-mini"
    carful_database_url: str = "sqlite:///./carful_backend.sqlite3"
    carful_allowed_origin: str = "*"
    moderation_model: str = "omni-moderation-latest"
    assistant_rate_limit: int = 20
    assistant_rate_window_seconds: int = 300

    model_config = SettingsConfigDict(
        env_file=".env",
        env_prefix="",
        extra="ignore",
    )
