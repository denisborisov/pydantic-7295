export PYTHONDONTWRITEBYTECODE=1

# Pydantic way of setting multihost connection:
# export POSTGRES_DSN=postgresql+psycopg://user:password@0.0.0.0:5432,0.0.0.0:5432/database&target_session_attrs=read-write

# SQLAlchemy way of setting multihost connection:
export POSTGRES_DSN=postgresql+psycopg://user:password@/database?host=0.0.0.0:5432&host=0.0.0.0:5432&target_session_attrs=read-write


up-db:
    # Run a PostgreSQL container
	podman-compose up -d
	sleep 1

up-alembic: up-db
    # Run Alembic migrations
	poetry run alembic upgrade head

up-with-alembic: up-alembic
    # Run app by first creating a database and running migrations
	poetry run uvicorn src.main:app --reload

up-without-alembic:
    # Run app by first creating a database, but without alembic migrations
	poetry run uvicorn src.main:app --reload

down:
    # Remove a PostgreSQL container
	podman-compose down --remove-orphans \
                        --volumes

cleanup: down
	podman rm $(podman ps -aq)
	podman rmi $(podman image ls -q)
