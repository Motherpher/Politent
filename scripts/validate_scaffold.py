#!/usr/bin/env python3
from pathlib import Path
import sys
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]

required = [
    "README.md",
    ".env.example",
    "docker-compose.yml",
    "Makefile",
    "config/politent.yml",
    "config/qgis_postgis_connection.example.ini",
    "schemas/politent_core_schema.sql",
    "project/HOUSEHOLD_EXECUTION_PROTOCOL.md",
    "project/WP_MANIFEST.yml",
    "qgis/Politent_3_0.qgs",
]

missing = [p for p in required if not (ROOT / p).exists()]
if missing:
    print("Missing required scaffold files:")
    for p in missing:
        print(f" - {p}")
    sys.exit(1)

schema = (ROOT / "schemas/politent_core_schema.sql").read_text(encoding="utf-8")
required_tables = [
    "source_registry", "party", "election", "geo_unit", "geo_crosswalk",
    "election_result", "respondent", "respondent_vote", "respondent_party",
    "issue", "respondent_issue", "model_run", "measure_registry", "estimate",
    "spatial_weight_definition", "spatial_weight_edge",
    "estimate_source_lineage", "derived_field", "gis_layer_registry",
]
for table in required_tables:
    if f"CREATE TABLE {table}" not in schema:
        print(f"Schema missing required table: {table}")
        sys.exit(1)

try:
    tree = ET.parse(ROOT / "qgis/Politent_3_0.qgs")
except Exception as exc:
    print(f"QGIS project XML invalid: {exc}")
    sys.exit(1)

root = tree.getroot()
if root.tag != "qgis":
    print("Unexpected QGIS project root element")
    sys.exit(1)

print("Politent WP1.1 scaffold validation: PASS")
