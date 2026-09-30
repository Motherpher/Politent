# WP1.3 — Election Backbone Preparation

**State:** STAGED

WP1.3 is prepared while WP1.2 remains active. It must not be accepted before the versioned geography/crosswalk gate is accepted.

## Initial source contract

The first ingestion targets are official final parliamentary election result workbooks for 2022 and 2026.

The source-workbook auditor records sheet structure and SHA-256 before a parser is specified. This deliberately avoids hard-coding workbook assumptions before the official source structure has been inspected.

## Dependency

Every polling-district row will eventually join through the canonical versioned geography registry created in WP1.2. No join by human-readable district name is accepted as canonical.
