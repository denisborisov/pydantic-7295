"""App settings."""

import pydantic
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    postgres_dsn: str = pydantic.Field(default="")
    # postgres_dsn: pydantic.PostgresDsn = pydantic.Field(default="")

AppSettings = Settings()
