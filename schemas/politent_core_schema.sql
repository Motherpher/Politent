-- Politent 3.0
-- Canonical PostgreSQL + PostGIS scaffold.
-- Source-specific adapters and analytical model code belong outside this schema.

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE source_registry (
    source_id TEXT PRIMARY KEY,
    source_name TEXT NOT NULL,
    source_url TEXT,
    retrieved_at TIMESTAMPTZ,
    license_or_access TEXT,
    jurisdiction TEXT,
    unit_of_analysis TEXT,
    time_coverage TEXT,
    geo_coverage TEXT,
    checksum TEXT,
    notes TEXT
);

CREATE TABLE party (
    party_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    short_name TEXT,
    country_code TEXT,
    valid_from DATE,
    valid_to DATE,
    predecessor_party_id TEXT REFERENCES party(party_id),
    successor_party_id TEXT REFERENCES party(party_id),
    source_id TEXT REFERENCES source_registry(source_id),
    notes TEXT
);

CREATE TABLE election (
    election_id TEXT PRIMARY KEY,
    country_code TEXT NOT NULL,
    election_type TEXT NOT NULL,
    election_date DATE NOT NULL,
    institution TEXT,
    rules_version TEXT,
    threshold_rule TEXT,
    source_id TEXT REFERENCES source_registry(source_id)
);

CREATE TABLE geo_unit (
    geo_id TEXT PRIMARY KEY,
    geo_type TEXT NOT NULL,
    canonical_name TEXT,
    valid_from DATE,
    valid_to DATE,
    parent_geo_id TEXT REFERENCES geo_unit(geo_id),
    geometry_version TEXT NOT NULL,
    crs_epsg INTEGER,
    geom GEOMETRY(MULTIPOLYGON),
    source_id TEXT REFERENCES source_registry(source_id),
    notes TEXT
);

CREATE INDEX geo_unit_geom_gix
ON geo_unit
USING GIST (geom);

CREATE TABLE geo_crosswalk (
    crosswalk_id BIGSERIAL PRIMARY KEY,
    source_geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    target_geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    valid_time DATE,
    weight_type TEXT NOT NULL,
    weight_value DOUBLE PRECISION NOT NULL CHECK (weight_value >= 0),
    method TEXT NOT NULL,
    uncertainty DOUBLE PRECISION,
    source_id TEXT REFERENCES source_registry(source_id)
);

CREATE TABLE election_result (
    election_id TEXT NOT NULL REFERENCES election(election_id),
    geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    party_id TEXT NOT NULL REFERENCES party(party_id),
    eligible_voters BIGINT,
    votes_cast BIGINT,
    valid_votes BIGINT,
    party_votes BIGINT,
    vote_share DOUBLE PRECISION,
    turnout DOUBLE PRECISION,
    source_id TEXT REFERENCES source_registry(source_id),
    PRIMARY KEY (election_id, geo_id, party_id)
);

CREATE TABLE respondent (
    respondent_id TEXT NOT NULL,
    source_id TEXT NOT NULL REFERENCES source_registry(source_id),
    wave_id TEXT NOT NULL,
    time_point DATE,
    survey_weight DOUBLE PRECISION,
    available_geo_id TEXT REFERENCES geo_unit(geo_id),
    PRIMARY KEY (respondent_id, source_id, wave_id)
);

CREATE TABLE respondent_vote (
    respondent_id TEXT NOT NULL,
    source_id TEXT NOT NULL,
    wave_id TEXT NOT NULL,
    election_id TEXT REFERENCES election(election_id),
    vote_current_party_id TEXT REFERENCES party(party_id),
    vote_previous_party_id TEXT REFERENCES party(party_id),
    party_identification_party_id TEXT REFERENCES party(party_id),
    party_identification_strength DOUBLE PRECISION,
    decision_timing TEXT,
    certainty DOUBLE PRECISION,
    ideology_left_right DOUBLE PRECISION,
    FOREIGN KEY (respondent_id, source_id, wave_id)
      REFERENCES respondent(respondent_id, source_id, wave_id)
);

CREATE TABLE respondent_party (
    respondent_id TEXT NOT NULL,
    source_id TEXT NOT NULL,
    wave_id TEXT NOT NULL,
    party_id TEXT NOT NULL REFERENCES party(party_id),
    ptv DOUBLE PRECISION,
    considered_direct BOOLEAN,
    party_sympathy DOUBLE PRECISION,
    leader_evaluation DOUBLE PRECISION,
    ideology_distance DOUBLE PRECISION,
    PRIMARY KEY (respondent_id, source_id, wave_id, party_id),
    FOREIGN KEY (respondent_id, source_id, wave_id)
      REFERENCES respondent(respondent_id, source_id, wave_id)
);

CREATE TABLE issue (
    issue_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    definition_version TEXT,
    description TEXT
);

CREATE TABLE respondent_issue (
    respondent_id TEXT NOT NULL,
    source_id TEXT NOT NULL,
    wave_id TEXT NOT NULL,
    issue_id TEXT NOT NULL REFERENCES issue(issue_id),
    salience DOUBLE PRECISION,
    position DOUBLE PRECISION,
    ownership_party_id TEXT REFERENCES party(party_id),
    PRIMARY KEY (respondent_id, source_id, wave_id, issue_id),
    FOREIGN KEY (respondent_id, source_id, wave_id)
      REFERENCES respondent(respondent_id, source_id, wave_id)
);

CREATE TABLE model_run (
    model_run_id TEXT PRIMARY KEY,
    model_family TEXT NOT NULL,
    model_version TEXT NOT NULL,
    git_commit TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    input_snapshot TEXT,
    specification JSONB NOT NULL,
    random_seed BIGINT,
    validation_status TEXT,
    notes TEXT
);

CREATE TABLE measure_registry (
    measure_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    measure_class TEXT NOT NULL,
    epistemic_state TEXT NOT NULL
      CHECK (epistemic_state IN ('OBSERVED','ESTIMATED','DERIVED','HYPOTHESIS','SCENARIO')),
    definition TEXT NOT NULL,
    unit TEXT,
    bounded_min DOUBLE PRECISION,
    bounded_max DOUBLE PRECISION
);

CREATE TABLE estimate (
    estimate_id BIGSERIAL PRIMARY KEY,
    model_run_id TEXT REFERENCES model_run(model_run_id),
    measure_id TEXT NOT NULL REFERENCES measure_registry(measure_id),
    party_id TEXT REFERENCES party(party_id),
    comparison_party_id TEXT REFERENCES party(party_id),
    geo_id TEXT REFERENCES geo_unit(geo_id),
    time_point DATE,
    estimate DOUBLE PRECISION NOT NULL,
    standard_error DOUBLE PRECISION,
    lower_50 DOUBLE PRECISION,
    upper_50 DOUBLE PRECISION,
    lower_80 DOUBLE PRECISION,
    upper_80 DOUBLE PRECISION,
    lower_95 DOUBLE PRECISION,
    upper_95 DOUBLE PRECISION,
    posterior_sd DOUBLE PRECISION,
    effective_sample_size DOUBLE PRECISION,
    direct_sample_size DOUBLE PRECISION,
    quality_flag TEXT,
    metadata JSONB
);

CREATE INDEX estimate_lookup_idx
ON estimate (
    measure_id,
    party_id,
    comparison_party_id,
    geo_id,
    time_point
);

CREATE TABLE spatial_weight_definition (
    weight_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    method TEXT NOT NULL,
    parameters JSONB NOT NULL,
    normalization TEXT,
    geo_type TEXT NOT NULL,
    geometry_version TEXT NOT NULL,
    created_by_model_run TEXT REFERENCES model_run(model_run_id)
);

CREATE TABLE spatial_weight_edge (
    weight_id TEXT NOT NULL REFERENCES spatial_weight_definition(weight_id),
    source_geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    target_geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    weight_value DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (weight_id, source_geo_id, target_geo_id)
);

CREATE TABLE estimate_source_lineage (
    estimate_id BIGINT NOT NULL REFERENCES estimate(estimate_id),
    source_id TEXT NOT NULL REFERENCES source_registry(source_id),
    role TEXT NOT NULL,
    PRIMARY KEY (estimate_id, source_id, role)
);

CREATE TABLE derived_field (
    field_id TEXT PRIMARY KEY,
    field_type TEXT NOT NULL,
    model_run_id TEXT NOT NULL REFERENCES model_run(model_run_id),
    time_point DATE,
    canonical_name TEXT,
    method TEXT NOT NULL,
    parameters JSONB NOT NULL,
    geom GEOMETRY(MULTIPOLYGON),
    metadata JSONB
);

CREATE INDEX derived_field_geom_gix
ON derived_field
USING GIST (geom);

CREATE TABLE gis_layer_registry (
    layer_id TEXT PRIMARY KEY,
    measure_id TEXT NOT NULL REFERENCES measure_registry(measure_id),
    model_run_id TEXT REFERENCES model_run(model_run_id),
    party_id TEXT REFERENCES party(party_id),
    geo_type TEXT,
    geometry_version TEXT,
    weight_id TEXT REFERENCES spatial_weight_definition(weight_id),
    time_reference DATE,
    estimate_field TEXT,
    uncertainty_fields JSONB,
    quality_field TEXT,
    classification_method TEXT,
    classification_breaks JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    metadata JSONB
);
