# Politent 3.0 — Established Component Registry

This registry distinguishes **established components** from **Politent synthesis constructs**.

| Component | Established method/concept | Politent job | Canonical reference |
|---|---|---|---|
| Partisan attachment | Party identification | Durable political attachment | Campbell et al. (1960) |
| Electoral utility | PTV / measured electoral utilities | Continuous voter-party potential | van der Eijk et al. (2006) |
| Viable alternatives | Consideration Set Models | Candidate/party inclusion stage | Oscarsson & Rosema (2019) |
| Party competition | Two-hurdle consideration/selection | Breadth vs conditional selection | Steenbergen & Willi (2019) |
| Voter movement | Transition matrices | Realised directional switching | Panel/retrospective survey analysis |
| Aggregate change | Pedersen Index | Net party-system volatility | Pedersen (1979) |
| Hidden attachment | Latent class / LTA / HMM | Test latent attachment states | Collins & Lanza (2010); Rabiner (1989) |
| Small-area estimation | MRP | Survey-to-local-population estimates | Gelman & Little (1997) |
| Aggregate-to-individual estimation | Ecological inference | Estimate compatible transition structure | King (1997) |
| Global spatial association | Moran's I | Overall geographic clustering | Moran (1950) |
| Local spatial association | LISA / Local Moran | Local clusters and outliers | Anselin (1995) |
| Local concentration | Getis–Ord G family | High/low concentration | Getis & Ord (1992) |
| Spatial random effects | CAR/ICAR / lattice models | Structured geographic effects | Besag (1974) |
| Bayesian latent Gaussian inference | INLA | Efficient spatial/spatiotemporal estimation | Rue et al. (2009) |
| Ideological choice space | Spatial theory of voting | Party/voter ideological distances | Downs (1957); Enelow & Hinich (1984) |
| Party-position data | CHES | Time-varying expert party coordinates | Chapel Hill Expert Survey |
| Issue context | Issue ownership / salience | Modular issue explanation layer | Petrocik (1996); Bélanger & Meguid (2008) |
| GIS process automation | QGIS Model Designer | Reusable geoprocessing workflows | QGIS documentation |
| Space-time GIS | Space Time Cube | GIS representation of location × time | Esri documentation |
| Open spatial analytics | PySAL | Spatial weights, ESDA, regression | PySAL documentation |

---

## 1. Party identification

The Michigan tradition distinguishes current vote from comparatively durable partisan attachment.

**Politent use:** attachment and persistence layer.

**Not equivalent to:** current vote, repeated vote, ideological location or consideration-set membership.

Foundation: Campbell, A., Converse, P.E., Miller, W.E. & Stokes, D.E. (1960), *The American Voter*.

---

## 2. PTV / measured electoral utilities

van der Eijk, van der Brug, Kroh & Franklin (2006) argue for directly measured electoral utilities.

**Politent use:** continuous voter-party viability.

**Operational principle:** retain the original scale; do not arbitrarily convert PTV into probability without calibration.

DOI: https://doi.org/10.1016/j.electstud.2005.06.012

---

## 3. Consideration Set Models

Oscarsson & Rosema (2019) describe electoral choice as a two-stage process: creation of a viable set followed by selection.

**Politent use:** distinguish inclusion from final choice.

**Preferred data:** direct consideration-set measures and pre-election panel designs when available.

DOI: https://doi.org/10.1016/j.electstud.2018.08.003

Swedish application: Oscarsson & Oskarson (2019), DOI: https://doi.org/10.1016/j.electstud.2018.08.005

---

## 4. Two-hurdle electoral competition

Steenbergen & Willi (2019) move consideration-set logic to party competition and distinguish consideration from selection.

**Politent use:** electoral breadth and conditional conversion/selection as separate quantities.

DOI: https://doi.org/10.1016/j.electstud.2018.08.004

---

## 5. Transition matrices

Transition matrices estimate:

\[
T_{pq}=Pr(q_t\mid p_{t-1})
\]

**Politent use:** observed individual movement where panel/retrospective data support it.

**Critical rule:** aggregate vote-share change is not an individual transition matrix.

---

## 6. Pedersen electoral volatility

\[
EV_t=\frac12\sum_p |v_{p,t}-v_{p,t-1}|
\]

**Politent use:** net aggregate party-system movement.

**Limitation:** reciprocal individual switching can cancel in aggregate totals.

Reference: Pedersen (1979), DOI: https://doi.org/10.1111/j.1475-6765.1979.tb01267.x

---

## 7. Latent Class Analysis, Latent Transition Analysis and HMM

These model unobserved states from observed indicators.

**Politent use:** test whether political attachment is better represented by discrete hidden states and how those states change.

**Critical rule:** Core/Sphere/Periphery labels are assigned only if empirical states support them.

References:

- Collins, L.M. & Lanza, S.T. (2010), *Latent Class and Latent Transition Analysis*. https://doi.org/10.1002/9780470567333
- Rabiner, L.R. (1989), HMM tutorial. https://doi.org/10.1109/5.18626
- Stan HMM functions: https://mc-stan.org/docs/functions-reference/hidden_markov_models.html

---

## 8. Multilevel Regression and Poststratification

MRP combines multilevel survey modelling with population-cell counts.

**Politent use:** small-area estimates of attachment, consideration, PTV or potential.

**Critical rule:** MRP values are estimates with uncertainty, not directly observed local voter states.

Foundation:

- Gelman, A. & Little, T.C. (1997), *Poststratification into Many Categories Using Hierarchical Logistic Regression*. https://sites.stat.columbia.edu/gelman/research/published/poststrat3.pdf

---

## 9. Ecological inference

Ecological inference estimates individual-level relationships compatible with aggregate margins under explicit assumptions.

**Politent use:** transition estimation only where individual transition data are unavailable and the EI design is defensible.

**Critical rule:** output must remain labelled as estimated from aggregate data.

Reference: King, G. (1997), *A Solution to the Ecological Inference Problem*. https://gking.harvard.edu/publication/a-solution-to-the-ecological-inference-problem-reconstructing-individual-behavior-from-aggregate-data/

---

## 10. Moran's I

Moran's I is a global spatial-autocorrelation statistic.

**Politent use:** test whether mapped political quantities exhibit overall spatial clustering relative to a declared spatial-weight matrix.

Reference: Moran (1950), DOI: https://doi.org/10.1093/biomet/37.1-2.17

---

## 11. LISA / Local Moran

Anselin's Local Indicators of Spatial Association identify local contributions to global spatial association and local spatial outliers.

**Politent use:** locate local clusters and spatial exceptions.

Reference: Anselin (1995), DOI: https://doi.org/10.1111/j.1538-4632.1995.tb00338.x

---

## 12. Getis–Ord

The Getis–Ord G family measures spatial association/concentration over defined neighbourhoods.

**Politent use:** local high/low concentration analysis as an alternative/complement to LISA.

Reference: Getis & Ord (1992), DOI: https://doi.org/10.1111/j.1538-4632.1992.tb00261.x

---

## 13. CAR/ICAR and lattice models

Besag's lattice framework is foundational for conditional spatial models.

**Politent use:** structured geographic random effects in Bayesian small-area/spatiotemporal models.

Reference: Besag (1974), DOI: https://doi.org/10.1111/j.2517-6161.1974.tb00999.x

---

## 14. INLA

Integrated Nested Laplace Approximation provides approximate Bayesian inference for latent Gaussian models.

**Politent use:** computational route for structured spatial and spatiotemporal models.

Reference: Rue, Martino & Chopin (2009), DOI: https://doi.org/10.1111/j.1467-9868.2008.00700.x

---

## 15. Spatial theory of voting

Spatial voting theory represents voters and political alternatives in policy/ideological space.

**Politent use:** ideological distance layer independent of observed voter overlap and transitions.

Foundations:

- Downs, A. (1957), *An Economic Theory of Democracy*.
- Enelow, J.M. & Hinich, M.J. (1984), *The Spatial Theory of Voting*.

---

## 16. Chapel Hill Expert Survey

CHES estimates party positions on general left-right, economic left-right, GAL–TAN, European integration and other issues across repeated waves.

**Politent use:** external time-varying party-position coordinates.

Official source: https://www.chesdata.eu/ches-europe/

**Constraint:** CHES-Europe begins in 1999. Earlier historical reconstruction requires other sources or explicit non-comparability.

---

## 17. Issue ownership and issue salience

Issue ownership concerns perceived party competence/credibility on issues. Issue salience concerns issue importance.

**Politent use:** context plug-ins related to consideration, potential, transitions and geography.

References:

- Petrocik (1996), DOI: https://doi.org/10.2307/2111797
- Bélanger & Meguid (2008), DOI: https://doi.org/10.1016/j.electstud.2008.01.001

---

## 18. QGIS Model Designer

QGIS Model Designer allows chained geoprocessing steps to be saved as reproducible workflows.

**Politent use:** reusable geometry validation, crosswalk, join, surface and export workflows.

Documentation: https://docs.qgis.org/latest/en/docs/user_manual/processing/modeler.html

---

## 19. ArcGIS Space Time Cube

The Space Time Cube is an established GIS structure for storing spatial locations through time.

**Politent use:** one implementation option for \((g,t)\) political surfaces.

Documentation: https://pro.arcgis.com/en/pro-app/latest/tool-reference/space-time-pattern-mining/create-space-time-cube.htm

---

## 20. PySAL

PySAL is an open Python ecosystem for spatial weights, exploratory spatial-data analysis and spatial modelling.

**Politent use:** programmable, reproducible spatial workflows.

Documentation:

- https://pysal.org/libpysal/
- https://pysal.org/esda/

---

# Politent-only synthesis constructs

The following should **not** be attributed to the external methods above as if they already existed in this exact form:

### Political depth
A synthesized representation of attachment/persistence beneath observed support.

### Political breadth
A Politent interpretive layer derived from consideration/electoral-potential measures.

### Political terrain
The joint GIS rendering of multiple political-state quantities.

### Functional political field
A derived spatial cluster/region based on similarity and, where imposed, geographic continuity.

### Core–Sphere–Periphery
A topographic visualization that may be used only after empirical validation of the underlying attachment/potential structure.

The value of Politent lies in making these established components interoperable while retaining their methodological boundaries.
