-- Politent WP1.4 — candidate poststratification frames
-- These declare possible direct frames only. They do not assert that cell data have been ingested.

INSERT INTO poststrat_frame
(frame_id, canonical_name, reference_year, geography_release_id, population_universe, dimensions, frame_status, construction_method, notes, metadata)
VALUES
(
  'PS_2025_DESO2025_AGE_SEX',
  'DeSO 2025 population by age and sex — candidate frame',
  2025,
  'DESO_2025',
  'Population registered by DeSO, age and sex as defined by SCB matrix 000007Y7',
  '["age","sex"]'::jsonb,
  'CANDIDATE',
  'DIRECT_JOINT_TABLE',
  'Primary first MRP poststratification candidate. Cells must be ingested directly from the joint SCB table; no marginal multiplication.',
  '{"matrix_id":"000007Y7","source_id":"SCB_CTX_POP_AGE_SEX_DESO"}'::jsonb
)
ON CONFLICT (frame_id) DO NOTHING;

INSERT INTO poststrat_frame_source
(frame_id, context_source_id, source_role)
VALUES
('PS_2025_DESO2025_AGE_SEX','SCB_CTX_POP_AGE_SEX_DESO','DIRECT_CELL_SOURCE')
ON CONFLICT DO NOTHING;
