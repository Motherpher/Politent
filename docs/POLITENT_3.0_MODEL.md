# Politent 3.0 — Full Model Specification

## 0. Status and purpose

**Politent — Political Potential Analysis** is a multilevel spatiotemporal synthesis framework for analysing political attachment, party viability, consideration sets, electoral potential, voter transitions, ideology, issue context, geography and time.

Politent is **not one statistical model**. It is an analytical architecture that connects established models while preserving the distinct estimand of each component.

The canonical unit is:

\[
(p,g,t)
\]

where:

- \(p\) = party or political alternative;
- \(g\) = geographic unit or model-derived spatial field;
- \(t\) = time or election wave.

At the individual level, voter \(i\) is added:

\[
(i,p,g,t)
\]

Politent's core state object is:

\[
\mathcal P_{pgt}
=
\{A,U,C,EP,O,T,I,Q,S,\tau,\Omega\}_{pgt}
\]

with:

- \(A\) partisan attachment;
- \(U\) measured electoral utility / Propensity to Vote;
- \(C\) consideration-set membership/probability;
- \(EP\) electoral potential;
- \(O\) overlap between viable electorates;
- \(T\) voter-transition structure;
- \(I\) ideological position and distance;
- \(Q\) issue context;
- \(S\) spatial structure;
- \(\tau\) temporal structure;
- \(\Omega\) uncertainty, quality and provenance.

---

# 1. Analytical premise

A vote is an observed electoral choice:

\[
V_{ipt}\in\{0,1\}
\]

but an observed vote does not describe the complete political relationship of a voter to the available alternatives.

A voter may:

- identify strongly with one party;
- consider several parties;
- assign non-zero propensity-to-vote values to several parties;
- move between parties over time;
- occupy a relatively stable ideological location despite changing party choice;
- be located in a geographic area whose political structure differs from the national average.

Politent therefore separates:

\[
\text{observed vote}
\neq
\text{attachment}
\neq
\text{consideration}
\neq
\text{potential}
\neq
\text{transition}
\]

The synthesis begins only after these components have been estimated separately.

---

# 2. Four analytical levels

## 2.1 Individual level

For respondent \(i\), party \(p\), time \(t\):

\[
Y_{ipt}=
\{
Vote,
PID,
PIDStrength,
PTV,
Consideration,
Ideology,
IssueResponses,
Certainty,
DecisionTiming,
Demography
\}
\]

The exact observed variables depend on the source. Missing constructs are not silently imputed unless an explicit model does so.

## 2.2 Voter–party dyad

Politent uses a long voter-party representation:

\[
(i,p,t)
\]

rather than only one selected party per voter.

This is required for PTV, consideration-set and overlap analysis because several parties may be politically viable for the same individual.

## 2.3 Geographic population level

Individual or dyadic quantities are aggregated or estimated to area \(g\):

\[
\widehat A_{pgt},
\widehat C_{pgt},
\widehat{EP}_{pgt},
\widehat O_{pqgt},
\widehat T_{pqgt}
\]

with explicit uncertainty.

## 2.4 Political-system level

Party-level surfaces can be combined to describe:

- system attachment;
- average consideration-set breadth;
- overlap structure;
- ideological-field structure;
- electoral volatility;
- spatial segregation or mixing;
- temporal persistence and change.

---

# 3. Partisan attachment

The foundational construct is the party-identification tradition associated with Campbell, Converse, Miller and Stokes.

Politent keeps **party identification** separate from current vote.

A generic attachment construct is:

\[
A_{ipt}
=
f(
PID_{ipt},
PIDStrength_{ipt},
VoteHistory_{it},
Persistence_{ipt},
Certainty_{it},
...
)
\]

No single indicator is automatically equivalent to a “core voter.”

A repeated vote is evidence of behavioural persistence.

Party identification is evidence of subjective partisan attachment.

PTV is evidence of electoral utility.

Consideration-set membership is evidence of viability.

These indicators may converge, but Politent does not force them to be identical.

---

# 4. Measured electoral utilities / PTV

Van der Eijk, van der Brug, Kroh and Franklin (2006) propose analysing directly measured electoral utilities rather than treating the nominal party choice as the only dependent variable.

For each voter–party dyad:

\[
U_{ipt}=PTV_{ipt}
\]

and for voter \(i\):

\[
\mathbf U_i=
(U_{ip_1},U_{ip_2},...,U_{ip_J})
\]

This is central to Politent because it permits a political possibility space in which several parties may simultaneously have non-zero utility.

PTV is **not automatically interpreted as a calibrated probability of voting**. Calibration must be tested empirically.

---

# 5. Consideration Set Models

Consideration Set Models describe electoral choice as a staged process.

## Stage 1 — inclusion

\[
\mathcal U \rightarrow C_i
\]

The full universe of alternatives is reduced to a smaller set of viable alternatives.

## Stage 2 — selection

\[
C_i \rightarrow Vote_i
\]

One alternative is selected from the consideration set.

Oscarsson and Rosema (2019) set out the electoral CSM framework and recommend panel designs, direct measures of consideration and voter-party dyadic modelling.

Oscarsson and Oskarson (2019) apply this logic to Swedish panel data.

Politent therefore distinguishes:

\[
Pr(C_{ipt}=1)
\]

from:

\[
Pr(Vote_{ipt}=1\mid C_{ipt}=1)
\]

The first is a viability/inclusion process.

The second is a conditional selection process.

---

# 6. Two-hurdle party competition

Steenbergen and Willi (2019) extend consideration-set logic to party competition.

A simplified representation is:

\[
\pi_p=\alpha_p\tau_p
\]

where:

- \(\alpha_p\) = probability of being considered;
- \(\tau_p\) = probability of selection conditional on consideration.

Politent generalises this to geography and time:

\[
\pi_{pgt}=\alpha_{pgt}\tau_{pgt}
\]

This produces two distinct analytical dimensions:

### Breadth
How widely is party \(p\) considered viable?

### Conditional selection
Among voters for whom \(p\) is viable, how often is it selected?

A party can therefore have a broad potential electorate but relatively low conditional selection, or a narrower potential electorate with higher conditional selection.

---

# 7. Electoral potential

Politent defines **electoral potential** as a party's estimated viable electorate under a declared operational definition.

Depending on data availability, this may be based on:

- direct consideration-set membership;
- a validated PTV threshold;
- modelled consideration probability;
- a continuous expected-potential measure.

For a binary consideration definition:

\[
EP_{pt}=\sum_i w_i Pr(C_{ipt}=1)
\]

For geographic area \(g\):

\[
EP_{pgt}
=
\frac
{\sum_{i\in g}w_iPr(C_{ipt}=1)}
{\sum_{i\in g}w_i}
\]

Any threshold used to convert continuous PTV into a binary potential electorate must be documented and sensitivity-tested.

---

# 8. Electoral overlap

Because viable alternatives can overlap, Politent calculates party-pair overlap.

For parties \(p,q\):

\[
O_{pq,t}
=
Pr(p\in C_i \land q\in C_i)
\]

A normalized alternative may be:

\[
J_{pq,t}
=
\frac
{Pr(p\in C_i \land q\in C_i)}
{Pr(p\in C_i \lor q\in C_i)}
\]

which is analogous to a weighted Jaccard overlap.

Overlap is not the same as ideological distance and not the same as observed voter switching.

Politent retains all three.

---

# 9. Voter transitions

Where individual panel data or valid retrospective previous-vote data exist:

\[
T_{pq,t}
=
Pr(Vote_t=q\mid Vote_{t-1}=p)
\]

The transition matrix contains:

- retention;
- inflow;
- outflow;
- reciprocal switching;
- asymmetric switching;
- transitions to/from abstention or other categories.

The direction matters:

\[
T_{pq}\neq T_{qp}
\]

in general.

A symmetrised transition affinity may be created for a particular visualization, but the directional matrix remains canonical.

---

# 10. Aggregate electoral volatility

Politent retains the Pedersen index as a system-level aggregate measure:

\[
EV_t=
\frac12
\sum_p
|v_{p,t}-v_{p,t-1}|
\]

This measures net aggregate change.

It does **not** measure all individual-level switching because reciprocal flows may cancel in aggregate totals.

Politent therefore keeps separate:

\[
\text{aggregate volatility}
\]

\[
\text{individual transition}
\]

\[
\text{change in electoral potential}
\]

---

# 11. Latent attachment states

The former HSm Core–Sphere–Periphery language is not imposed as three pre-existing voter categories.

Let:

\[
Z_{it}
\]

be an unobserved political-attachment state.

Observed measures \(Y_{it}\) are treated as indicators of that state.

A latent-class formulation estimates:

\[
Pr(Z_i=k\mid Y_i)
\]

A longitudinal latent-transition or Hidden Markov formulation estimates:

\[
Pr(Z_t=k\mid Y_{1:t})
\]

and:

\[
Pr(Z_{t+1}=b\mid Z_t=a)
\]

Politent requires comparison of:

- continuous attachment models;
- 2-state latent models;
- 3-state latent models;
- 4-state or other plausible alternatives.

Only if a three-state structure is empirically defensible may the topographic labels be used:

- **Core** — high attachment and persistence;
- **Sphere** — high viability/consideration with weaker exclusivity;
- **Periphery** — meaningful but more conditional potential.

Thus Core–Sphere–Periphery becomes an **output ontology**, not an assumption.

---

# 12. Political depth

**Political depth** is a Politent synthesis construct.

It describes the distribution of attachment/persistence beneath observed support.

One representation is:

\[
D_{pt}
=
E[d(Z_{it})\mid Vote_{ipt}=1]
\]

where the state values \(d(Z)\) are estimated or externally justified.

A continuous alternative is:

\[
D_{pt}
=
E[A_{ipt}\mid Vote_{ipt}=1]
\]

Politent should prefer interpretable distributions over an opaque single number.

If a composite depth index is produced, the components, scaling, validation and sensitivity analysis must be published.

---

# 13. Small-area estimation using MRP

Survey samples are normally too sparse for direct estimates in every small geographic unit.

Politent therefore uses Multilevel Regression and Poststratification when appropriate.

A generic model is:

\[
g(E[Y_i])
=
X_i\beta
+
u_{region[i]}
+
u_{municipality[i]}
+
u_{demographic[i]}
+...
\]

Predictions are produced for poststratification cells \(c\):

\[
\widehat\theta_c
\]

and aggregated using known population counts:

\[
\widehat Y_g
=
\frac
{\sum_{c\in g}N_c\widehat\theta_c}
{\sum_{c\in g}N_c}
\]

Possible targets include:

- attachment probability;
- consideration probability;
- expected PTV;
- electoral potential;
- system fluidity.

Known aggregate election totals may be used for calibration where statistically justified, but calibration must be explicit.

---

# 14. Ecological inference

Aggregate geographic results cannot directly identify individual transition patterns.

Politent therefore treats ecological inference as a distinct model family.

The EI problem is:

> Given aggregate marginal totals across areas, what individual-level cross-tabulation is statistically compatible with them under an explicit model?

King (1997) is a foundational reference.

EI outputs must be labelled:

**estimated from aggregate data**

and must not be described as observed switching.

---

# 15. Multi-scale geography

Politent supports parallel geographies:

\[
SmallArea
\leftrightarrow
PollingDistrict
\leftrightarrow
Municipality
\leftrightarrow
Constituency
\leftrightarrow
County/Region
\leftrightarrow
Nation
\]

plus model-derived functional political fields.

The hierarchy is not assumed to be perfectly nested.

Every geometry has:

- identifier;
- type;
- valid-from and valid-to dates;
- geometry version;
- coordinate reference system;
- parent relationship where meaningful;
- provenance.

Crosswalks connect non-matching geographies.

---

# 16. MAUP and geographic sensitivity

Politent explicitly recognizes the **Modifiable Areal Unit Problem**.

A result may change when:

- boundaries change;
- units are aggregated;
- scale changes;
- zoning changes.

Therefore spatial conclusions should be sensitivity-tested across plausible geographic units.

A conclusion robust at DeSO/small-area, polling-district and municipal scales deserves more confidence than one that appears only under one arbitrary partition.

---

# 17. Spatial association

For a geographic variable \(y_g\), Politent can estimate global spatial autocorrelation using Moran's \(I\).

The statistic is conditional on a spatial weight matrix \(W\).

Possible \(W\) definitions include:

- Queen contiguity;
- Rook contiguity;
- k-nearest neighbours;
- distance thresholds;
- adaptive distance;
- mobility or commuting networks;
- other substantively justified relational networks.

The weight definition is part of the model specification.

---

# 18. Local spatial association

Local Indicators of Spatial Association (LISA) decompose spatial association into local contributions.

Politent uses LISA/Local Moran to identify:

- high-high clusters;
- low-low clusters;
- high-low spatial outliers;
- low-high spatial outliers.

Getis–Ord statistics can be used as an alternative or complement for local high/low concentration.

These describe spatial pattern.

They do not identify causal mechanisms.

---

# 19. Spatially structured models

Where spatial dependence remains after observed covariates are included, Politent may use spatial random effects.

A general spatiotemporal model is:

\[
Y_{gt}
=
X_{gt}\beta
+
u_g
+
v_t
+
w_{gt}
+
\epsilon_{gt}
\]

where:

- \(u_g\) = structured or unstructured spatial effect;
- \(v_t\) = temporal effect;
- \(w_{gt}\) = space-time interaction.

CAR/ICAR model families are linked to the lattice-model tradition associated with Besag (1974).

INLA is one computational route for Bayesian latent Gaussian models.

---

# 20. Spatial association, dependence and diffusion

Politent makes a hard distinction:

\[
Spatial\ association
\neq
Spatial\ dependence
\neq
Spatial\ diffusion
\]

A diffusion hypothesis may use a lagged model such as:

\[
\Delta Y_{g,t}
=
\beta_0
+
\rho W\Delta Y_{t-1}
+
X_{g,t}\beta
+
\epsilon_{g,t}
\]

Even a positive \(\rho\) does not by itself demonstrate interpersonal contagion.

Alternative explanations include:

- shared socioeconomic conditions;
- common media environments;
- population mobility;
- institutions;
- common shocks;
- omitted spatially patterned variables.

Causal diffusion requires a stronger identification strategy.

---

# 21. Ideological space

Politent includes ideology as a distinct coordinate system rather than defining party proximity solely from voter flows.

A party may be represented as:

\[
I_{pt}
=
(LR, EconomicLR, GAL\text{-}TAN, ...)
\]

Voters may also have self-placement or issue-position vectors.

Politent can calculate ideological distance:

\[
D^{IDEO}_{pq,t}
\]

and behavioural distance based on overlap/transition/PTV:

\[
D^{BEHAV}_{pq,t}
\]

The discrepancy:

\[
R_{pq,t}
=
D^{BEHAV}_{pq,t}
-
D^{IDEO}_{pq,t}
\]

is an analytical result rather than an error to be forced away.

CHES is one established source of longitudinal expert party-position data in Europe.

---

# 22. Issue layers

Issue modules are optional context layers.

For issue \(q\):

\[
Q_{qgt}
=
\{
Salience,
Position,
Ownership
\}
\]

Politent may analyse interactions between issue variables and:

- attachment;
- consideration;
- potential;
- transitions;
- geography;
- time.

Issue ownership and issue salience are kept conceptually separate.

No issue layer is interpreted as causally decisive without an appropriate design.

---

# 23. Time architecture

Politent distinguishes at least three temporal resolutions.

## Election-to-election structure

Long-term change in:

- attachment;
- consideration;
- potential;
- transitions;
- ideological alignment.

## Inter-election trajectory

Where repeated polling/panel data exist:

\[
t_1,t_2,...,t_n
\]

Politent can estimate structural and transitory movement.

## Campaign-period dynamics

Short-run movement may be modelled using state-space or repeated-wave methods.

Campaign data are not allowed to retroactively redefine the entire preceding mandate period.

---

# 24. Persistence and episodic change

A useful analytical decomposition is:

\[
Observed_{pgt}
=
Persistent_{pgt}
+
Transitory_{pgt}
+
Noise_{pgt}
\]

This is a modelling objective, not an identity assumed to be true.

Politent can test whether change is:

- persistent;
- emerging;
- intensifying;
- weakening;
- episodic;
- oscillating.

Classification requires explicit temporal methods and uncertainty.

---

# 25. Functional political fields

A **functional political field** is a model-derived geography whose units have similar political-state profiles and, when required, geographic continuity.

Possible features include:

\[
\{
A,
EP,
O,
T,
I
\}
\]

Possible clustering approaches include:

- spatially constrained hierarchical clustering;
- graph community detection with geographic constraints;
- regionalization algorithms;
- Bayesian spatial mixture models.

Any derived field must report:

- input features;
- feature scaling;
- spatial constraint;
- algorithm;
- number-of-clusters rule;
- robustness across specifications.

Administrative borders remain an overlay, not the assumed boundary of political structure.

---

# 26. System-level attachment and fluidity

Politent can aggregate across parties.

A system attachment measure asks:

> How much of the electorate exhibits high attachment to at least one political alternative?

A system fluidity measure asks:

> How broad and weakly exclusive are voters' viable choice sets?

This allows two areas with similar close vote outcomes to have different underlying structures:

- multiple deeply anchored electorates;
- broad overlapping potential with weak attachment.

Politent describes the distinction; it does not rank one as politically preferable.

---

# 27. Uncertainty as a first-class dimension

Every estimated quantity should retain uncertainty.

For any estimate:

\[
\widehat\theta
\]

Politent stores, where applicable:

- standard error;
- posterior standard deviation;
- 50%, 80% and 95% intervals;
- effective sample size;
- direct sample size;
- model quality flag;
- source lineage.

Maps must not display high-precision boundaries where the posterior distributions overlap strongly.

---

# 28. Source and epistemic states

Every Politent variable receives an epistemic state:

### OBSERVED
Directly measured or officially reported.

### ESTIMATED
Produced by a statistical model.

### DERIVED
Computed from observed/estimated quantities.

### HYPOTHESIS
A relationship being tested.

### SCENARIO
A deliberately altered assumption or input for sensitivity analysis.

These states must remain visible in exports and documentation.

---

# 29. Politent outputs

Canonical outputs include:

1. **Vote Surface** — observed outcome.
2. **Attachment Surface** — estimated partisan attachment.
3. **PTV Surface** — expected electoral utility.
4. **Consideration Surface** — inclusion probability.
5. **Electoral Potential Surface** — size of viable electorate.
6. **Overlap Map** — pairwise shared potential.
7. **Transition Matrix/Map** — directional voter movement.
8. **Political Depth Surface** — attachment distribution beneath support.
9. **System Fluidity Surface** — overlap/breadth across the system.
10. **Ideological Residual Map** — mismatch between ideological and behavioural proximity.
11. **Issue–Potential Map** — issue context intersected with political potential.
12. **Historical Terrain** — change through time.
13. **Functional Political Fields** — derived political geography.
14. **Uncertainty Surface** — confidence/credible uncertainty.
15. **Data Quality Surface** — where the model is strongly versus weakly identified.

---

# 30. Appropriate analytical uses

Politent can analyse questions such as:

- Does observed support coincide with high or low attachment?
- Is electoral potential broader than current vote share?
- Do parties share large consideration-set overlaps?
- Are transitions symmetric or directional?
- Does aggregate volatility correspond to individual switching?
- Are local political structures spatially clustered?
- Are apparent clusters robust across geographic scales?
- Do behavioural and ideological proximity agree?
- Does issue salience covary with consideration or transition?
- Are latent attachment states stable through time?
- Do data-derived political fields cross administrative borders?

These are descriptive and inferential questions.

Politent does not prescribe how to persuade, target or manipulate specific voters.

---

# 31. What Politent does not infer automatically

Politent does not automatically infer:

- individual behaviour from aggregate totals;
- causal persuasion from association;
- social contagion from spatial clustering;
- that Core/Sphere/Periphery necessarily exist as exactly three states;
- future election outcomes from potential surfaces;
- that ideological proximity causes overlap;
- that estimated small-area values are observed facts;
- that a close election implies a fluid electorate.

---

# 32. Canonical synthesis rule

> **Each established model does one job. Politent connects the jobs.**

Politent's novelty claim, if any, belongs at the level of **synthesis architecture, interoperability, spatialization and joint interpretation**, not at the level of rebranding established statistical methods.
