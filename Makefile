.PHONY: help env up down reset status db-shell db-health validate bootstrap

SHELL := /bin/bash

help:
	@echo "Politent 3.0 local targets"
	@echo "  make env       Create .env from template if missing"
	@echo "  make up        Start PostGIS"
	@echo "  make down      Stop services"
	@echo "  make reset     Remove PostGIS volume and rebuild"
	@echo "  make status    Show service status"
	@echo "  make db-shell  Open psql shell"
	@echo "  make db-health Run database schema healthcheck"
	@echo "  make validate  Run repository bootstrap validation"
	@echo "  make bootstrap env + up + db-health + validate"

env:
	@test -f .env || cp .env.example .env

up: env
	docker compose up -d --wait db

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up -d --wait db

status:
	docker compose ps

db-shell:
	docker compose exec db psql -U $${POLITENT_DB_USER:-politent} -d $${POLITENT_DB_NAME:-politent}

db-health:
	./scripts/db_healthcheck.sh

validate:
	python3 scripts/validate_scaffold.py

bootstrap: env up db-health validate
