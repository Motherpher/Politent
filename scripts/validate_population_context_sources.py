#!/usr/bin/env python3
import json
import re
import sys
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
manifest_path = ROOT / "sources/population_context_sources.json"
data = json.loads(manifest_path.read_text(encoding="utf-8"))

sources = data.get("sources", [])
if len(sources) < 5:
    raise SystemExit("Expected at least five SCB population/context source definitions")

seen = set()
for src in sources:
    sid = src["source_id"]
    if sid in seen:
        raise SystemExit(f"Duplicate source_id: {sid}")
    seen.add(sid)

    for key in ("matrix_id","title","landing_page","time_coverage","joint_dimensions","geo_version_rule"):
        if not src.get(key):
            raise SystemExit(f"{sid}: missing {key}")

    if "region" not in src["joint_dimensions"] or "year" not in src["joint_dimensions"]:
        raise SystemExit(f"{sid}: joint_dimensions must include region and year")

    req = urllib.request.Request(
        src["landing_page"],
        headers={"User-Agent":"Politent/3.0 source-validation (research infrastructure)"}
    )
    with urllib.request.urlopen(req, timeout=45) as response:
        html = response.read().decode("utf-8", errors="ignore")

    normalized = re.sub(r"\s+", " ", html)
    if src["matrix_id"] not in normalized:
        raise SystemExit(f"{sid}: matrix id {src['matrix_id']} not found on live SCB page")

print(f"Population/context source validation: PASS ({len(sources)} SCB tables)")
