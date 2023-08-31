# PostgresDsn fails for multiple hosts

The original issue is described here: https://github.com/pydantic/pydantic/issues/7295

## Project dependencies

Main dependencies are described in `pyproject.toml` file.

I also use these tools to start the project:
- poetry
- podman
- podman-compose

## How to reproduce the issue

The current state of the project is running finely, without any issue, because it uses this notation of multihost connection:

```shell
export POSTGRES_DSN=postgresql+psycopg://user:password@/database?host=0.0.0.0:5432&host=0.0.0.0:5432&target_session_attrs=read-write
```

You can see it at the top of Makefile. The problem is that I cannot validate this string with `pydantic.PostgresDsn` typing hint.

If you comment this line and uncomment another one with Pydantic notation, then neither Alembic nor SQLAlchemy will work:

```shell
export POSTGRES_DSN=postgresql+psycopg://user:password@0.0.0.0:5432,0.0.0.0:5432/database&target_session_attrs=read-write
```

That's the crux of the issue.
