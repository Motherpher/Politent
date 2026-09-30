#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
path = ROOT / "sources/geography_sources.json"
data = json.loads(path.read_text(encoding='utf-8'))
sources = data.get('sources', [])
assert sources, 'No geography sources registered'

ids = [s['source_id'] for s in sources]
assert len(ids) == len(set(ids)), 'Duplicate source_id in geography manifest'

for s in sources:
    for key in ('source_id','authority','geo_type','version_label','landing_page','format','access'):
        assert s.get(key), f"{s.get('source_id')}: missing {key}"
    if 'expected_feature_count' in s:
        assert isinstance(s['expected_feature_count'], int) and s['expected_feature_count'] > 0

expected = {
    'SCB_DESO_2018': 5984,
    'SCB_DESO_2025': 6160,
    'VAL_POLLING_DISTRICTS_2026': 6312,
}
for source_id, n in expected.items():
    match = next((s for s in sources if s['source_id'] == source_id), None)
    assert match is not None, f'Missing required source {source_id}'
    assert match.get('expected_feature_count') == n, f'{source_id}: unexpected feature count contract'

print(f'Geography source manifest validation: PASS ({len(sources)} sources)')
