# Politent 3.0 — Implementation Roadmap

## Stage 0 — Canon and reproducibility

Lock:
- terminology;
- estimands;
- data contracts;
- epistemic states;
- model-run registry;
- reference registry;
- uncertainty standard;
- public/private data boundary.

**Exit condition:** every future output can be traced to source and model.

---

# Stage 1 — Election-result backbone

Ingest official results with:
- party;
- election;
- geography;
- turnout;
- eligible voters;
- valid votes;
- party votes;
- rule metadata;
- source provenance.

Validate local totals against higher-level published totals.

---

# Stage 2 — Party and geography lineage

Build:
- party rename/predecessor/successor crosswalk;
- geography version registry;
- historical boundary crosswalks.

No historical modelling starts before these are stable.

---

# Stage 3 — Survey/panel backbone

Convert survey material to:
- respondent table;
- voter-party dyad table;
- issue table.

Preserve:
- original questionnaire wording;
- variable codes;
- weights;
- missing-value rules;
- wave structure.

---

# Stage 4 — Transition engine

Produce:
- weighted retention;
- directional party-to-party transitions;
- abstention transitions;
- uncertainty;
- aggregate Pedersen volatility as a separate measure.

No aggregate-to-individual transition without an explicit EI model.

---

# Stage 5 — PTV and consideration engine

Estimate:
- PTV distributions;
- direct consideration sets;
- modelled consideration probability;
- conditional selection;
- electoral potential;
- pairwise overlap.

Threshold sensitivity must be built in from the start.

---

# Stage 6 — Attachment engine

Construct transparent attachment measures from:
- party identification;
- identification strength;
- persistence/history;
- PTV;
- consideration exclusivity;
- certainty where available.

Create a continuous baseline before latent states.

---

# Stage 7 — Latent-state engine

Compare:
- continuous baseline;
- 2-state latent;
- 3-state latent;
- 4-state latent;
- time-varying alternatives if identifiable.

Only after validation may Core/Sphere/Periphery be used as empirical state labels.

---

# Stage 8 — Small-area/MRP engine

Build poststratification cells from population data and fit local models for:
- attachment;
- consideration;
- electoral potential;
- system fluidity.

Validate against known aggregates and geographic holdouts.

---

# Stage 9 — Spatial engine

For each selected surface:
- build multiple plausible weight matrices;
- calculate Global Moran's I;
- calculate LISA;
- calculate Getis–Ord where useful;
- test spatial model residuals;
- escalate to CAR/ICAR/spatiotemporal models only when justified.

---

# Stage 10 — Ideology engine

Ingest:
- CHES for 1999 onward where applicable;
- voter self-placement;
- other validated historical sources when required.

Build:
- ideological distance;
- behavioural distance;
- ideology-behaviour residuals.

Do not silently backcast CHES into periods it does not cover.

---

# Stage 11 — Issue plug-ins

Add one issue at a time.

Each issue module requires:
- definition;
- wording/source;
- salience;
- position;
- ownership where measured;
- time reference;
- geography;
- uncertainty;
- hypothesis being tested.

---

# Stage 12 — Space-time layer

Create the canonical \((p,g,t)\) structure.

Potential outputs:
- persistence;
- emergence;
- erosion;
- episodic change;
- temporal outliers.

Any categorical temporal label must have an explicit rule.

---

# Stage 13 — Functional political fields

Test model-derived areas using:
- attachment profile;
- potential profile;
- overlap profile;
- transition profile;
- ideology;
- spatial contiguity/network structure.

Require robustness across alternative algorithms and parameters before publication.

---

# Stage 14 — Historical reconstruction

Work backwards election by election.

Assign data-quality grade A–D.

Do not render sparse historical periods with the same visual precision as rich contemporary periods.

---

# Stage 15 — Historical backtest

For each election \(t\):

1. freeze all information available at \(t\);
2. estimate Politent state;
3. archive the model run;
4. compare with later observed data;
5. measure persistence/calibration;
6. revise only in a new version.

Historical models are never silently overwritten.

---

# Stage 16 — Publication

Publish:
- model documentation;
- data dictionary;
- reference registry;
- model-run metadata;
- uncertainty;
- validation results;
- changelog;
- map layers;
- API documentation where used.

---

# Recommended first empirical build

The implementation order should be:

\[
Official\ outcomes
\rightarrow
Transitions
\rightarrow
PTV/Consideration
\rightarrow
Attachment
\rightarrow
MRP
\rightarrow
Spatial\ analysis
\rightarrow
Ideology
\rightarrow
Issues
\rightarrow
Historical\ validation
\]

This reduces the risk of constructing visually persuasive maps before the underlying quantities are scientifically identified.

---

# Repository milestones

## v3.0-alpha
Architecture + data contracts + references.

## v3.0-beta.1
Election/survey harmonisation and transition engine.

## v3.0-beta.2
PTV/consideration and electoral-potential engine.

## v3.0-beta.3
Attachment + latent-state comparison.

## v3.0-beta.4
MRP + GIS surfaces.

## v3.0-rc.1
Spatial/ideology/issue integration.

## v3.0
Validated end-to-end reproducible stack with historical backtest.
