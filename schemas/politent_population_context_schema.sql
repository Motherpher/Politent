-- Politent WP1.4 — population/context and poststratification schema

CREATE TABLE IF NOT EXISTS population_context_source (
    context_source_id TEXT PRIMARY KEY,
    source_id TEXT NOT NULL REFERENCES source_registry(source_id),
    matrix_id TEXT NOT NULL,
    title TEXT NOT NULL,
    landing_page TEXT NOT NULL,
    time_coverage TEXT NOT NULL,
    unit TEXT,
    reference_time TEXT,
    joint_dimensions JSONB NOT NULL,
    geo_version_rule JSONB NOT NULL,
    disclosure_note TEXT,
    metadata JSONB
);

CREATE TABLE IF NOT EXISTS context_variable (
    context_variable_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    dimension_name TEXT NOT NULL,
    category_code TEXT,
    category_label TEXT,
    unit TEXT,
    source_matrix_id TEXT,
    metadata JSONB
);

CREATE TABLE IF NOT EXISTS context_observation (
    context_observation_id BIGSERIAL PRIMARY KEY,
    context_source_id TEXT NOT NULL REFERENCES population_context_source(context_source_id),
    geo_id TEXT REFERENCES geo_unit(geo_id),
    geography_release_id TEXT REFERENCES geography_release(release_id),
    reference_year INTEGER NOT NULL,
    observation_name TEXT,
    dimensions JSONB NOT NULL,
    value DOUBLE PRECISION,
    value_status TEXT NOT NULL DEFAULT 'OBSERVED'
      CHECK (value_status IN ('OBSERVED','SUPPRESSED','MISSING','NOT_APPLICABLE')),
    disclosure_control_method TEXT,
    source_cell_key TEXT,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS context_observation_lookup_idx
ON context_observation (context_source_id, geography_release_id, reference_year, geo_id);

CREATE TABLE IF NOT EXISTS poststrat_frame (
    frame_id TEXT PRIMARY KEY,
    canonical_name TEXT NOT NULL,
    reference_year INTEGER NOT NULL,
    geography_release_id TEXT NOT NULL REFERENCES geography_release(release_id),
    population_universe TEXT NOT NULL,
    dimensions JSONB NOT NULL,
    frame_status TEXT NOT NULL DEFAULT 'CANDIDATE'
      CHECK (frame_status IN ('CANDIDATE','VALIDATED','REJECTED','SUPERSEDED')),
    construction_method TEXT NOT NULL
      CHECK (construction_method IN ('DIRECT_JOINT_TABLE','AUTHORIZED_MICRODATA','MODELLED_JOINT_DISTRIBUTION')),
    model_run_id TEXT REFERENCES model_run(model_run_id),
    notes TEXT,
    metadata JSONB
);

CREATE TABLE IF NOT EXISTS poststrat_frame_source (
    frame_id TEXT NOT NULL REFERENCES poststrat_frame(frame_id) ON DELETE CASCADE,
    context_source_id TEXT NOT NULL REFERENCES population_context_source(context_source_id),
    source_role TEXT NOT NULL,
    PRIMARY KEY (frame_id, context_source_id, source_role)
);

CREATE TABLE IF NOT EXISTS poststrat_cell (
    frame_id TEXT NOT NULL REFERENCES poststrat_frame(frame_id) ON DELETE CASCADE,
    cell_id TEXT NOT NULL,
    geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    attributes JSONB NOT NULL,
    population_count DOUBLE PRECISION NOT NULL CHECK (population_count >= 0),
    count_status TEXT NOT NULL DEFAULT 'OBSERVED'
      CHECK (count_status IN ('OBSERVED','ESTIMATED','SUPPRESSED_ADJUSTED')),
    uncertainty DOUBLE PRECISION,
    source_cell_key TEXT,
    metadata JSONB,
    PRIMARY KEY (frame_id, cell_id)
);

CREATE INDEX IF NOT EXISTS poststrat_cell_geo_idx
ON poststrat_cell (frame_id, geo_id);

CREATE TABLE IF NOT EXISTS area_context_covariate (
    context_source_id TEXT NOT NULL REFERENCES population_context_source(context_source_id),
    geo_id TEXT NOT NULL REFERENCES geo_unit(geo_id),
    reference_year INTEGER NOT NULL,
    covariate_name TEXT NOT NULL,
    value DOUBLE PRECISION,
    unit TEXT,
    value_status TEXT NOT NULL DEFAULT 'OBSERVED',
    metadata JSONB,
    PRIMARY KEY (context_source_id, geo_id, reference_year, covariate_name)
);

COMMENT ON TABLE poststrat_frame IS
'Poststratification frames may only claim joint dimensions supported by one joint source, authorized microdata, or an explicit modelled joint distribution with propagated uncertainty.';
