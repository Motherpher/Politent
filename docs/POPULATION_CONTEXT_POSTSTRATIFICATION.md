# WP1.4 — Population, Context and Poststratification Frame

## Objective

WP1.4 builds the population/context warehouse required for later MRP and contextual spatial analysis.

The implementation deliberately separates:

1. **joint population frames** — dimensions observed together in one defensible source;
2. **area-level contextual covariates** — variables that can explain local variation but are not automatically part of the poststratification cell;
3. **modelled joint distributions** — allowed only when separately specified and uncertainty is propagated.

## Initial SCB source families

| Source | Matrix | Joint dimensions | Initial Politent role |
|---|---:|---|---|
| Population by age and sex | 000007Y7 | region × age × sex × year | primary candidate poststratification frame |
| Population by region of birth and sex | 000007Y5 | region × birth region × sex × year | secondary/specialized frame |
| Labour-market status | 0000089X | observation × region × sex × age × year | context or specialized frame |
| Educational attainment | 000007Z6 | region × education × year | context or reduced frame |
| Net-income structure | 000008A4 | observation × region × sex × year | contextual covariate |

## Canonical first frame

The first declared candidate is:

`PS_2025_DESO2025_AGE_SEX`

with:

[
g \times age \times sex
]

for DeSO 2025 and reference year 2025.

This is a **candidate frame**, not yet a completed poststratification dataset. Acceptance requires actual source-cell ingestion and QA.

## Critical non-combination rule

The following operation is prohibited:

[
P(age,sex) \times P(education) \times P(background)
\Rightarrow
P(age,sex,education,background)
]

unless conditional independence is explicitly modelled and uncertainty is carried through as a modelled joint distribution.

Separate marginal tables do not identify a joint population distribution.

## Geography/version handling

SCB tables explicitly distinguish older DeSO classifications from DeSO 2025 for recent years. Politent stores geography release with every observation and frame.

No old DeSO-coded value is moved to DeSO 2025 merely by matching labels.

## Disclosure control

Small-area SCB tables may use disclosure-control methods that alter exact additivity. Politent therefore stores disclosure-control metadata and does not fail a source simply because displayed components do not sum exactly to a separately displayed total when SCB documents this behaviour.

## QGIS role

WP1.4 does not yet create political surfaces.

QGIS group `30_POPULATION_CONTEXT` will later consume:
- raw/derived demographic denominators;
- education/labour/income context;
- poststratification frame QA;
- geography-version indicators.

The population/context layer remains distinct from voter estimates.
