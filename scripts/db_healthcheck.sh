#!/usr/bin/env bash
set -euo pipefail

DB_USER="${POLITENT_DB_USER:-politent}"
DB_NAME="${POLITENT_DB_NAME:-politent}"

required_tables=(
  source_registry party election geo_unit geo_crosswalk election_result
  respondent respondent_vote respondent_party issue respondent_issue
  model_run measure_registry estimate spatial_weight_definition
  spatial_weight_edge estimate_source_lineage derived_field gis_layer_registry
)

echo "Checking PostGIS extension..."
docker compose exec -T db psql -U "$DB_USER" -d "$DB_NAME" -Atc "SELECT extversion FROM pg_extension WHERE extname='postgis';" | grep -Eq "^[0-9]+\."

echo "Checking required tables..."
for table in "${required_tables[@]}"; do
  found="$(docker compose exec -T db psql -U "$DB_USER" -d "$DB_NAME" -Atc "SELECT to_regclass('public.$table');")"
  if [[ "$found" != "$table" ]]; then
    echo "Missing table: $table" >&2
    exit 1
  fi
done

echo "Checking SWEREF99 TM support (EPSG:3006)..."
docker compose exec -T db psql -U "$DB_USER" -d "$DB_NAME" -Atc "SELECT count(*) FROM spatial_ref_sys WHERE srid=3006;" | grep -q "^1$"

echo "PostGIS schema healthcheck: PASS"
