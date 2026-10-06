# Politent 3.0 — Political Potential Analysis

**Politent** is a multilevel spatiotemporal synthesis framework for analysing partisan attachment, electoral utilities, consideration sets, electoral potential, voter transitions, ideology, issues, geography and time in one interoperable architecture.

> **Core proposition:** an election result is an observed outcome. Politent models the wider political-potential landscape from which that outcome emerges, while keeping observed data, estimated latent quantities and derived spatial interpretations analytically separate.

Politent does **not** claim to replace the established models it uses. Its contribution is their disciplined integration into a common data, estimation, validation and GIS architecture.

## Canonical stack

```text
6  ANALYTICAL OUTPUTS
   descriptive research · diagnostics · issue layers · historical change · sensitivity analysis
                               ↑
5  GIS / POLITICAL TERRAIN
   attachment · potential · overlap · transitions · functional fields · space-time · uncertainty
                               ↑
4  POLITENT SYNTHESIS
   depth · breadth · overlap · movement · geography · time · context · uncertainty
                               ↑
3  ESTABLISHED ANALYTICAL ENGINES
   party identification / partisan attachment
   PTV / measured electoral utilities
   consideration-set and two-hurdle models
   transition matrices / electoral volatility
   latent class / latent transition / Hidden Markov models
   MRP / small-area estimation / ecological inference
   Moran's I / LISA / Getis–Ord / spatial models / INLA
   spatial voting / ideology / CHES
   issue salience / issue ownership
                               ↑
2  HARMONISED POLITICAL DATA MODEL
   party_id · geo_id · time_id · election_id · source_id · weights · crosswalks · provenance
                               ↑
1  RAW EMPIRICAL DATA
   election results · surveys/panels · population · GIS · polls · ideology · issues
```

## Canonical documents

- [Full model](docs/POLITENT_3.0_MODEL.md)
- [Established component registry](docs/ESTABLISHED_COMPONENTS.md)
- [Full schematics](docs/SCHEMATICS.md)
- [Data and GIS architecture](docs/DATA_AND_GIS_ARCHITECTURE.md)
- [Technical implementation stack](docs/TECHNICAL_STACK.md)
- [Validation and hypothesis programme](docs/VALIDATION_AND_HYPOTHESES.md)
- [Implementation roadmap](docs/IMPLEMENTATION_ROADMAP.md)
- [Reference registry](docs/REFERENCES.md)
- [PostgreSQL/PostGIS core schema](schemas/politent_core_schema.sql)

## What is synthetic in Politent?

The following are **Politent synthesis constructs**, not claims that the underlying literature uses these exact names:

- **Political depth** — the distribution of attachment/persistence beneath observed support.
- **Political breadth** — the extent of a party's viable/considered electorate.
- **Political terrain** — the GIS representation of attachment, potential, overlap, movement and uncertainty.
- **Functional political fields** — model-derived contiguous or networked areas with similar political-state profiles.
- **Core–Sphere–Periphery** — a possible *derived topographic representation* of validated continuous or latent estimates, never an imposed voter taxonomy.

## Scientific boundary

Politent must:

1. distinguish observed values, estimates and derived interpretations;
2. preserve weights, provenance, geography versions and model versions;
3. carry uncertainty through small-area and spatial outputs;
4. distinguish spatial association, spatial dependence and causal diffusion;
5. never infer individual voter transitions directly from aggregate vote changes;
6. validate latent states rather than assume that exactly three states exist;
7. test sensitivity to geography, thresholds, priors and model specification;
8. keep descriptive/inferential analysis separate from political persuasion or individualized voter profiling.

**Version:** 3.0 architecture  
**Status:** canonical model definition and implementation scaffold

---

## Public provenance

<p align="left">
  <img src="https://raw.githubusercontent.com/Hybrismannen/form-flode-dna/main/assets/form-flode-logo.png" alt="Form & Flöde" width="120">
</p>

**Politent is developed by Linus Fast / Form & Flöde as an independent synthesis and analytical architecture.** The established statistical, electoral and spatial methods on which it draws remain attributable to their respective literatures and sources.

Public provenance is governed by the **FFC Public Provenance Standard v1.0**.

### Support independent Form & Flöde work

Politent is made publicly available as part of Form & Flöde's independent research and development work. If the framework is useful to you, you can support its continued development.

**[Support independent Form & Flöde work →](https://paypal.me/djlifehack)**
