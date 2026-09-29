# Politent 3.0 — Data and GIS Architecture

## 1. Non-negotiable data flow

\[
RAW
\rightarrow
HARMONISED
\rightarrow
MODELLED
\rightarrow
SPATIALISED
\rightarrow
PUBLISHED
\]

Raw observations are immutable.

Model outputs never overwrite raw data.

Every published estimate must be traceable to:
- source snapshot;
- transformation;
- model run;
- geography version;
- time reference;
- uncertainty object.

---

# 2. Canonical dimensions

The minimum identity system is:

```text
party_id
geo_id
time_id
election_id
source_id
model_run_id
measure_id
```

Where individual survey data exist:

```text
respondent_id
wave_id
weight
```

Where pairwise party relations exist:

```text
party_id
comparison_party_id
```

---

# 3. Data zones

## RAW

```text
data/raw/
  elections/
  surveys/
  panels/
  population/
  geography/
  polls/
  ideology/
  issues/
```

Every ingestion stores source URL/location, retrieval date, license/access status, checksum and unmodified source snapshot where permitted.

## HARMONISED

```text
data/harmonised/
  parties.parquet
  elections.parquet
  election_results.parquet
  respondents.parquet
  respondent_party.parquet
  respondent_issue.parquet
  geographies.parquet
  geo_crosswalks.parquet
```

## MODELLED

```text
data/modelled/
  attachment/
  consideration/
  electoral_potential/
  transitions/
  latent_states/
  mrp/
  ecological_inference/
  spatial/
  ideology/
  issues/
```

## SPATIAL / SERVING

```text
data/serving/
  geoparquet/
  geopackage/
  tiles/
  cubes/
  metadata/
```

---

# 4. Party registry

A party record should contain:

```text
party_id
canonical_name
short_name
country_code
valid_from
valid_to
predecessor_party_id
successor_party_id
source_id
notes
```

Party renames, mergers, splits and new entries must be explicitly crosswalked.

Historical analysis must not assume a fixed party universe.

---

# 5. Election registry

```text
election_id
country_code
election_type
election_date
institution
rules_version
threshold_rule
source_id
```

Electoral rules belong in metadata because comparability can be altered by rule changes.

---

# 6. Geographic registry

Every geographic unit has:

```text
geo_id
geo_type
canonical_name
valid_from
valid_to
parent_geo_id
geometry_version
crs_epsg
geometry
source_id
```

Politent supports parallel geographies rather than forcing one hierarchy.

---

# 7. Geography types

Possible types include:

- DeSO or equivalent small statistical areas;
- polling districts;
- municipality;
- constituency;
- county/region;
- country;
- regular grid/hexagon;
- model-derived functional field.

The last is explicitly marked **derived**.

---

# 8. Geography crosswalks

A crosswalk stores:

```text
source_geo_id
target_geo_id
valid_time
weight_type
weight_value
method
uncertainty
source_id
```

Preferred weighting order where data permit:

1. individual/address-point assignment;
2. eligible-electorate counts;
3. population points;
4. residential/building weights;
5. dasymetric interpolation;
6. simple area weighting as a last resort.

---

# 9. Survey respondent table

```text
respondent_id
source_id
wave_id
time_point
survey_weight
available_geo_id
vote_current
vote_previous
party_identification
party_identification_strength
decision_timing
certainty
ideology_self
```

Not every survey will contain every variable.

Missingness is represented explicitly.

---

# 10. Voter–party dyad table

```text
respondent_id
source_id
wave_id
party_id
ptv
considered_direct
party_sympathy
leader_evaluation
ideology_distance
```

This table is central because Politent needs all relevant party evaluations, not only the selected party.

---

# 11. Issue table

```text
respondent_id
wave_id
issue_id
salience
position
ownership_party_id
source_id
```

Issue definitions are versioned because question wording can change over time.

---

# 12. Model-run registry

Every estimation run receives:

```text
model_run_id
model_family
model_version
git_commit
created_at
input_snapshot
formula
priors_or_settings
validation_status
random_seed
notes
```

The goal is exact reproducibility.

---

# 13. Estimate object

Every estimate should support:

```text
model_run_id
measure_id
party_id
comparison_party_id
geo_id
time_point
estimate
standard_error
posterior_sd
lower_50
upper_50
lower_80
upper_80
lower_95
upper_95
effective_sample_size
direct_sample_size
quality_flag
epistemic_state
```

---

# 14. Epistemic states

Canonical values:

```text
OBSERVED
ESTIMATED
DERIVED
HYPOTHESIS
SCENARIO
```

These states propagate to map-layer metadata.

---

# 15. Spatial weight registry

Spatial statistics are conditional on \(W\), so \(W\) must be reproducible.

```text
weight_id
method
parameters
geo_type
geometry_version
normalization
created_by_model_run
```

Edges:

```text
weight_id
source_geo_id
target_geo_id
weight_value
```

---

# 16. Storage recommendations

### Canonical database
PostgreSQL + PostGIS.

### Columnar analytics
Parquet / GeoParquet.

### Exchange
GeoPackage.

### Multidimensional cube
netCDF / xarray where appropriate.

### Web delivery
vector tiles / PMTiles / GeoJSON for smaller outputs.

GeoJSON should not be the canonical large-volume storage format.

---

# 17. Raster versus vector

Politent should support both.

### Vector
Best for official administrative/polling units and auditable source alignment.

### Raster/grid
Useful for continuous surface representation and cross-boundary comparison.

### Rule
Never rasterize observed administrative election totals in a way that implies finer direct measurement than exists.

Interpolated surfaces must be labelled as estimates.

---

# 18. Functional political fields

Functional fields are created only after the underlying features are estimated.

Potential feature matrix:

\[
X_g=
[
A_g,
EP_g,
O_g,
T_g,
I_g
]
\]

Possible constraints:

- geographic contiguity;
- maximum within-field heterogeneity;
- minimum population/electorate size;
- stability through time.

Field boundaries are model outputs and must include a model-run ID.

---

# 19. MAUP checks

Every material geographic claim should, where feasible, be recalculated across at least two plausible zonings or scales.

Store:

```text
analysis_id
geo_specification
result_summary
stability_flag
```

If a result is highly scale-dependent, that dependency is part of the finding.

---

# 20. Privacy and disclosure

Politent is designed for aggregate political research.

It must not publish inferred individual political profiles.

Required safeguards:

- suppress or aggregate sparse cells;
- respect survey access/disclosure rules;
- remove direct identifiers;
- avoid map points that imply identifiable individuals;
- retain restricted microdata outside the public repository;
- store only permitted derived aggregates publicly.

---

# 21. Data quality grades

A practical quality grade may be assigned per measure/time/geography.

### A
Direct rich individual measures with strong survey design.

### B
Good individual survey evidence but one or more key constructs missing.

### C
Limited individual evidence and substantial model dependence.

### D
Predominantly aggregate historical reconstruction.

Quality grades are descriptive metadata, not certainty probabilities.

---

# 22. Source-ingest contract

Each source adapter outputs:

```yaml
source_id:
source_name:
source_url:
retrieved_at:
license_or_access:
jurisdiction:
time_coverage:
geo_coverage:
unit_of_analysis:
weight_variable:
missing_value_codes:
party_crosswalk_version:
geo_crosswalk_version:
transform_script:
checksum:
notes:
```

---

# 23. GIS layer metadata contract

Every map layer exports:

```yaml
layer_id:
measure_id:
epistemic_state:
model_run_id:
time_reference:
party_id:
geo_type:
geometry_version:
weight_id:
estimate_field:
uncertainty_fields:
quality_field:
source_lineage:
classification_method:
classification_breaks:
created_at:
```

This prevents attractive cartography from becoming detached from the statistical model that produced it.
