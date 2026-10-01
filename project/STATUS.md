# Politent Implementation Status

**Execution mode:** Household Family  
**Protocol:** POL-HH-001  
**Current phase:** Phase I — Data Foundation and QGIS Spatial Backbone  
**Current WP focus:** WP1.4 — Population/context and poststratification frame  
**Parallel active WP:** WP1.3 — Official election-result backbone  
**State:** ACTIVE

## Accepted

- WP1.1 — Project scaffold and PostGIS environment
- WP1.2 — Versioned geography and crosswalk engine

## Active

### WP1.3 — Official election-result backbone
Initial official election workbook audit has passed. Remaining gate:
parser contract → canonical party/election/result ingest → reconciliation against official totals → Director acceptance.

### WP1.4 — Population/context and poststratification frame
Activated because its hard dependencies (WP1.1 and WP1.2) are accepted.

Current execution:
SCB source audit → population/context source manifest → marginal/joint-variable compatibility matrix → poststratification schema → live-source/DB validation → Director review.

## Scientific guardrail

Politent will not manufacture a joint poststratification population from separate marginal SCB tables. A full age × sex × education × background × labour-status frame is only created where a valid joint source supports it. Otherwise the frame remains lower-dimensional or requires a separate defensible data source/model.

## Phase-I dependency state

WP1.5 remains STAGED until both WP1.3 and WP1.4 are ACCEPTED.
