"""App entrypoint."""

import fastapi
import sqlalchemy.ext.asyncio

from .settings import AppSettings


app = fastapi.FastAPI()


engine = sqlalchemy.ext.asyncio.create_async_engine(
        AppSettings.postgres_dsn,
        echo=True,
    )


session_factory = sqlalchemy.ext.asyncio.async_sessionmaker(
        bind=engine,
        autocommit=False,
        autoflush=False,
        expire_on_commit=False,
    )


session = session_factory()
