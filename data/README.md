# Politent Data Zones

Canonical flow:

RAW → HARMONISED → MODELLED → SPATIALISED → PUBLISHED

No raw source file is overwritten by a model output.

Expected local/runtime structure:

```
data/
  raw/
  harmonised/
  modelled/
  serving/
```

Large or restricted datasets must not be committed to Git unless explicitly licensed and appropriate. Source manifests, checksums, schemas and reproducible download/ingest code belong in the repository.
