-- Politent WP1.2 — seed official geography source and release registries
-- Idempotent; URLs and release metadata mirror sources/geography_sources.json.

INSERT INTO source_registry (source_id, source_name, source_url, retrieved_at, license_or_access, jurisdiction, unit_of_analysis, geo_coverage, notes)
VALUES
('SCB_DESO_2018','SCB DeSO 2018','https://www.scb.se/vara-tjanster/oppna-data/oppna-geodata/demografiska-statistikomraden-deso/',NULL,'OPEN','Sweden','DeSO polygon','Sweden','Versioned DeSO 2018 geography'),
('SCB_DESO_2025','SCB DeSO 2025','https://www.scb.se/vara-tjanster/oppna-data/oppna-geodata/demografiska-statistikomraden-deso/',NULL,'OPEN','Sweden','DeSO polygon','Sweden','Versioned DeSO 2025 geography'),
('SCB_DESO_CHANGES_2018_2025','SCB DeSO historical changes 2018-2025','https://www.scb.se/vara-tjanster/oppna-data/oppna-geodata/demografiska-statistikomraden-deso/',NULL,'OPEN','Sweden','crosswalk reference','Sweden','Official SCB historical-change reference'),
('VAL_POLLING_DISTRICTS_2026','Valmyndigheten polling districts 2026','https://www.val.se/valresultat-och-statistik/statistik-och-data/radata-val-2026',NULL,'OPEN','Sweden','polling-district polygon','Sweden','Official 2026 polling-district geography'),
('VAL_POLLING_DISTRICT_COMPARE_2022_2026','Valmyndigheten polling-district comparability 2022-2026','https://www.val.se/valresultat-och-statistik/statistik-och-data/radata-val-2026',NULL,'OPEN','Sweden','crosswalk reference','Sweden','Official district comparability workbook'),
('VAL_HISTORICAL_2002_2022','Valmyndigheten historical raw election data 2002-2022','https://www.val.se/valresultat-och-statistik/statistik-och-data/radata-fran-val-2002-2022',NULL,'OPEN','Sweden','historical electoral geography/results','Sweden','Historical Election Authority archive'),
('SCB_WFS','SCB geodata WFS','https://geodata.scb.se/geoserver/stat/wfs?service=wfs&version=1.1.0&request=GetCapabilities',NULL,'OPEN','Sweden','geodata service','Sweden','SCB WFS service')
ON CONFLICT (source_id) DO UPDATE SET
  source_name = EXCLUDED.source_name,
  source_url = EXCLUDED.source_url,
  license_or_access = EXCLUDED.license_or_access,
  jurisdiction = EXCLUDED.jurisdiction,
  unit_of_analysis = EXCLUDED.unit_of_analysis,
  geo_coverage = EXCLUDED.geo_coverage,
  notes = EXCLUDED.notes;

INSERT INTO geography_release
(release_id, source_id, geo_type, version_label, valid_from, canonical_crs_epsg, expected_feature_count, source_url, ingest_status, metadata)
VALUES
('DESO_2018','SCB_DESO_2018','DeSO','2018','2018-01-01',3006,5984,'https://geodata.scb.se/geoserver/stat/wfs?REQUEST=GetFeature&TYPENAMES=stat%3ADeSO_2018&outputFormat=geopackage&service=WFS&version=1.1.0','REGISTERED','{"authority":"SCB"}'::jsonb),
('DESO_2025','SCB_DESO_2025','DeSO','2025','2025-01-01',3006,6160,'https://geodata.scb.se/geoserver/stat/wfs?REQUEST=GetFeature&TYPENAMES=stat%3ADeSO_2025&outputFormat=geopackage&service=WFS&version=1.1.0','REGISTERED','{"authority":"SCB"}'::jsonb),
('POLLING_DISTRICT_2026','VAL_POLLING_DISTRICTS_2026','polling_district','2026','2026-01-01',3006,6312,'https://www.val.se/download/18.332cf48819bd61ac1513889/1785491689960/valdistrikt-riket-2026.zip','REGISTERED','{"authority":"Valmyndigheten"}'::jsonb)
ON CONFLICT (release_id) DO UPDATE SET
  source_id = EXCLUDED.source_id,
  geo_type = EXCLUDED.geo_type,
  version_label = EXCLUDED.version_label,
  valid_from = EXCLUDED.valid_from,
  canonical_crs_epsg = EXCLUDED.canonical_crs_epsg,
  expected_feature_count = EXCLUDED.expected_feature_count,
  source_url = EXCLUDED.source_url,
  metadata = EXCLUDED.metadata;
