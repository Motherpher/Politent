-- Politent WP1.2 — versioned geography extension

CREATE TABLE IF NOT EXISTS geography_release (
    release_id TEXT PRIMARY KEY,
    source_id TEXT NOT NULL REFERENCES source_registry(source_id),
    geo_type TEXT NOT NULL,
    version_label TEXT NOT NULL,
    valid_from DATE,
    valid_to DATE,
    canonical_crs_epsg INTEGER,
    expected_feature_count INTEGER,
    actual_feature_count INTEGER,
    source_url TEXT NOT NULL,
    source_checksum TEXT,
    ingest_status TEXT NOT NULL DEFAULT 'REGISTERED'
      CHECK (ingest_status IN ('REGISTERED','FETCHED','VALIDATED','IMPORTED','REJECTED')),
    metadata JSONB
);

CREATE TABLE IF NOT EXISTS geo_unit_release (
    geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    release_id TEXT NOT NULL REFERENCES geography_release(release_id),
    source_feature_id TEXT,
    source_code TEXT,
    source_name TEXT,
    source_properties JSONB,
    PRIMARY KEY (geo_id, release_id)
);

CREATE TABLE IF NOT EXISTS geo_crosswalk_quality (
    crosswalk_id BIGINT PRIMARY KEY REFERENCES geo_crosswalk(crosswalk_id) ON DELETE CASCADE,
    official_comparability_class TEXT,
    overlap_area_ratio DOUBLE PRECISION,
    electorate_weight DOUBLE PRECISION,
    population_weight DOUBLE PRECISION,
    source_assessment TEXT,
    quality_flag TEXT,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS geography_release_type_version_idx
ON geography_release (geo_type, version_label);

CREATE INDEX IF NOT EXISTS geo_unit_release_source_code_idx
ON geo_unit_release (release_id, source_code);
