# Politent Geography Versioning and Crosswalk Policy

## Canonical principle

Political geography is time-versioned. A code match is not sufficient evidence that two polygons are comparable.

Politent therefore preserves source authority, source release, geometry version, validity dates, CRS, source feature identifier, source code, source checksum, crosswalk method, crosswalk weight, crosswalk uncertainty and any official comparability assessment.

## Initial official sources

### SCB DeSO

Politent registers DeSO 2018 and DeSO 2025 as separate releases.

SCB states that statistics published on the older DeSO version are not retrospectively rewritten onto DeSO 2025. The releases therefore remain parallel canonical geographies.

Expected feature counts used as source QA:
- DeSO 2018: 5,984
- DeSO 2025: 6,160

### Valmyndigheten polling districts

Polling-district geometry is versioned by election.

The 2026 national GIS package is registered as the canonical 2026 polling-district release. Valmyndigheten supplies an official 2022–2026 comparability workbook. That assessment is preserved as source evidence rather than replaced by geometry overlap alone.

For earlier elections, Politent uses the Election Authority historical raw-data archive and year-specific geometry/comparability material where available.

## Crosswalk hierarchy

Preferred evidence for a crosswalk:

1. official identity/comparability statement;
2. electorate/address-point assignment;
3. population-point assignment;
4. residential/dasymetric weighting;
5. polygon overlap;
6. simple area weighting only as a fallback.

Official comparability and numerical interpolation weight are stored separately because they answer different questions.

## One-to-many and many-to-one changes

Crosswalks are edge tables, not one-column lookup tables.

A target area may reference multiple source areas, and a source area may contribute to multiple target areas.

Each edge stores source_geo_id, target_geo_id, method, weight_type, weight_value, uncertainty and source assessment where available.

## MAUP

No spatial conclusion is assumed invariant across DeSO, polling district, municipality or another zoning system.

Scale/zone sensitivity is a required later validation stage, but WP1.2 ensures the architecture can support it.

## QGIS rule

QGIS may visualize different releases together, but it must never silently display statistics coded to DeSO 2018 on DeSO 2025 boundaries, or election data on a different election-year polling-district geometry, unless a named and versioned crosswalk product has been applied.
