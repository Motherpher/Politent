# Politent 3.0 — Validation and Hypothesis Programme

## 1. Purpose

Politent is designed to expose its own assumptions to falsification.

The framework separates:

- established measurement/model components;
- Politent synthesis constructs;
- empirical hypotheses;
- scenarios/sensitivity tests.

A hypothesis is not made true by being representable in GIS.

---

# 2. Measurement hypotheses

## H1 — Attachment persistence

Higher estimated partisan attachment should be associated with greater subsequent vote persistence, conditional on the model specification.

Failure weakens the attachment measurement model.

## H2 — PTV and direct consideration converge but are non-identical

Higher PTV should be positively related to direct consideration-set membership where both are available.

Perfect equivalence is not expected or required.

## H3 — Earlier consideration relates to later selection

Where panel timing supports the test, the ultimately selected party should frequently be present in an earlier consideration set.

The exception rate is substantively informative.

## H4 — Latent-state separability

If a latent state model is used, the states should show:

- interpretable response profiles;
- adequate classification;
- reproducibility across samples/specifications;
- predictive relevance for later behaviour.

If not, a discrete Core–Sphere–Periphery interpretation is rejected.

---

# 3. Depth hypotheses

## H5 — Depth gradient

If political depth is valid, stronger attachment/depth should generally correspond to lower subsequent switching.

## H6 — Vote share and depth can diverge

Observed vote share may increase while average attachment depth falls, or vice versa.

This is a descriptive possibility to test, not an assumption about any party.

## H7 — Breadth can expand without vote-share growth

Consideration/electoral potential may broaden even when observed vote share remains relatively stable.

## H8 — Conditional selection can change without breadth changing

\[
Pr(Vote_p\mid Considered_p)
\]

may move independently of total consideration.

---

# 4. Overlap and transition hypotheses

## H9 — Overlap constrains possible transition

Very low consideration-set overlap should usually limit direct transition between parties.

High overlap permits transition but does not guarantee it.

## H10 — Directional asymmetry

\[
T_{pq}\neq T_{qp}
\]

may occur even when the shared consideration overlap is symmetric.

## H11 — Stable ideology with changing party choice

Some individual party switching may occur within relatively stable ideological self-placement.

This requires true panel evidence or comparably strong longitudinal data.

---

# 5. Geographic hypotheses

## H12 — Attachment varies geographically beyond vote share

Areas with similar party vote shares may have different estimated attachment structures.

## H13 — Close aggregate outcomes can represent different systems

A close aggregate result may arise from:
- deeply anchored opposing electorates; or
- broad overlapping consideration sets with weak exclusivity.

Politent should distinguish these structures if the data are sufficient.

## H14 — Administrative boundaries are imperfect political boundaries

Model-derived political similarity may cross municipal, regional or constituency borders.

## H15 — Geographic findings exhibit MAUP sensitivity

Some apparent clusters will change when the geographic unit or scale changes.

Robust claims should survive plausible alternative zoning/scale specifications.

---

# 6. Spatial hypotheses

## H16 — Spatial autocorrelation

Attachment, potential, overlap or transition estimates may display non-random spatial clustering.

## H17 — Local spatial outliers exist

Local Moran/LISA may identify areas whose political structure differs from neighbouring areas.

## H18 — Residual spatial dependence remains after covariates

After observed contextual variables are modelled, some spatially structured residual variation may remain.

## H19 — Neighbouring temporal change adds information

A lagged spatial term may improve explanation of subsequent local change after controls.

Even a positive result does **not** by itself prove interpersonal contagion.

---

# 7. Ideological hypotheses

## H20 — Ideological and behavioural proximity are related but imperfect

Party-pair ideological distance may correlate with overlap/transition proximity without fully determining it.

## H21 — Ideological field can be more stable than party choice

Some voters may move between parties while remaining within a relatively stable ideological location.

## H22 — Party-position movement and electorate movement are distinct

External expert placement changes and voter-potential changes need not move together.

---

# 8. Issue hypotheses

## H23 — Salience conditions issue relationships

The relationship between issue ownership/position and party consideration/choice should vary with issue salience.

This follows the logic tested by Bélanger & Meguid (2008).

## H24 — Issue relationships vary by attachment

Issue context may relate differently to strongly and weakly attached voters.

This is an interaction to estimate, not a built-in behavioural assumption.

## H25 — Issue geography differs from party geography

Issue salience or issue position may form spatial patterns that only partially align with party-potential surfaces.

---

# 9. Time hypotheses

## H26 — Persistent and transitory components are separable to some degree

Repeated observations may permit a model that distinguishes persistent political structure from short-run variation.

## H27 — Campaign-period volatility is not equivalent to long-term attachment change

Short-run preference movement should not automatically be interpreted as a change in durable attachment.

## H28 — Structural change can precede observed vote change

Potential/consideration or attachment structure may move before a large aggregate electoral shift is observed.

This is tested retrospectively through time-stamped data and does not constitute an election prediction.

---

# 10. Validation programme

Every major model receives four classes of validation.

## Internal

- residual diagnostics;
- convergence diagnostics;
- posterior predictive checks;
- calibration;
- classification quality for latent models;
- sensitivity to priors/thresholds.

## Temporal

- fit using information available through \(t\);
- freeze the model/data snapshot;
- evaluate against later observations;
- prohibit future-information leakage.

## Geographic

- geographic holdout where feasible;
- alternative \(W\) matrices;
- alternative scales/zones;
- cross-validation by region/municipality.

## Construct

- attachment against PID strength and later persistence;
- consideration model against direct consideration items;
- potential against subsequent viable-choice behaviour;
- latent-state labels against their observed indicator profiles.

---

# 11. Baseline models

Politent should not be accepted merely because it is complex.

Each advanced component should be compared with simpler baselines.

Examples:

### Attachment
- previous vote only;
- PID only;
- PID + strength;
- continuous multi-indicator attachment;
- latent model.

### Small area
- raw direct estimate;
- non-spatial multilevel model;
- spatial multilevel model;
- calibrated version.

### Time
- no temporal term;
- random time effects;
- AR structure;
- state-space alternative.

Complexity is retained only when it produces interpretable and validated improvement.

---

# 12. Model-comparison metrics

Depending on target and model family:

- log predictive density;
- log loss;
- Brier score;
- calibration error;
- RMSE/MAE for continuous targets;
- information criteria where appropriate;
- out-of-sample predictive checks;
- posterior predictive diagnostics.

These evaluate models, not political actors.

---

# 13. Uncertainty standard

A Politent estimate should be publishable only if it can answer:

1. What is being estimated?
2. From which source data?
3. At what geographic/time resolution?
4. Under which model?
5. With what uncertainty?
6. With what validation status?

If these cannot be answered, the map layer is not canonical.

---

# 14. Falsification rules

A synthetic claim should be narrowed, suspended or rejected when:

- results reverse repeatedly under plausible specifications;
- out-of-sample calibration is poor;
- a result depends on one arbitrary threshold;
- geographic findings disappear under reasonable zoning changes;
- latent states are not separable;
- spatial effects disappear after plausible contextual adjustment;
- model-derived proxies conflict with direct measures;
- uncertainty is too large to support the claimed distinction.

---

# 15. Scenario-analysis boundary

Politent may conduct sensitivity analysis by changing assumptions or inputs.

A scenario can ask:

> What happens to the modeled distribution if a specified transition parameter or consideration rate changes?

A scenario must not be reported as a prediction unless an independently validated predictive model justifies that interpretation.

Politent 3.0 does not define itself as an election-winner prediction engine.
