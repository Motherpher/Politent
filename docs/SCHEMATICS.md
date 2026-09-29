# Politent 3.0 — Full Schematics

All diagrams use Mermaid so GitHub remains the canonical editable source.

---

# S1. Full architecture

```mermaid
flowchart TB
    L1["1 · RAW EMPIRICAL DATA<br/>Election results · surveys/panels · population · geography · polls · ideology · issues"]
    L2["2 · HARMONISED POLITICAL DATA MODEL<br/>party_id · geo_id · time_id · election_id · source_id · weights · crosswalks"]
    L3["3 · ANALYTICAL ENGINES"]
    L4["4 · POLITENT SYNTHESIS<br/>Depth · Breadth · Overlap · Movement · Geography · Time · Context · Uncertainty"]
    L5["5 · GIS / POLITICAL TERRAIN<br/>Surfaces · clusters · functional fields · space-time · uncertainty"]
    L6["6 · ANALYTICAL OUTPUTS<br/>Description · inference · validation · issue layers · history · sensitivity"]

    L1 --> L2 --> L3 --> L4 --> L5 --> L6

    A["Partisan attachment"] --> L3
    U["PTV / electoral utilities"] --> L3
    C["Consideration sets / two-hurdle"] --> L3
    T["Transitions / volatility"] --> L3
    Z["Latent states / LTA / HMM"] --> L3
    M["MRP / ecological inference"] --> L3
    S["Spatial / spatiotemporal"] --> L3
    I["Ideology / CHES"] --> L3
    Q["Issue salience / ownership"] --> L3
```

---

# S2. Observed, estimated, derived

```mermaid
flowchart LR
  subgraph O["OBSERVED"]
    V["Vote"]
    PID["Party identification"]
    PTV["PTV"]
    CS["Direct consideration"]
    IDEO["Self-placement / issue position"]
    DEMO["Population / demographics"]
    GEO["Geometry"]
  end

  subgraph E["ESTIMATED"]
    ATT["Attachment"]
    CP["Consideration probability"]
    EP["Electoral potential"]
    LAT["Latent state"]
    TR["Transition estimates"]
    SAE["Small-area estimate"]
    SP["Spatial effect"]
  end

  subgraph D["DERIVED"]
    DEPTH["Political depth"]
    OVER["Overlap"]
    FLUID["System fluidity"]
    FIELD["Functional political fields"]
    TERRAIN["Political terrain"]
  end

  PID --> ATT
  V --> ATT
  PTV --> CP
  CS --> CP
  ATT --> LAT
  CP --> EP
  V --> TR

  DEMO --> SAE
  GEO --> SAE
  ATT --> SAE
  EP --> SAE
  SAE --> SP

  ATT --> DEPTH
  CP --> OVER
  EP --> OVER
  OVER --> FLUID
  SP --> FIELD
  DEPTH --> TERRAIN
  OVER --> TERRAIN
  FIELD --> TERRAIN
```

---

# S3. Voter–party dyad

```mermaid
flowchart TB
    V["Voter i"]
    P1["Party A"]
    P2["Party B"]
    P3["Party C"]

    V -->|"PTV / consideration / attachment"| P1
    V -->|"PTV / consideration / attachment"| P2
    V -->|"PTV / consideration / attachment"| P3

    P1 -. "only one may be selected as vote" .-> CH["Observed choice"]
    P2 -.-> CH
    P3 -.-> CH
```

Politent stores relationships to multiple parties rather than reducing the voter to the single selected choice.

---

# S4. Consideration-set / two-hurdle engine

```mermaid
flowchart LR
    U["All available parties"] --> C["Consideration set"]
    C --> S["Conditional selection"]
    S --> V["Observed vote"]

    LT["Longer-term structure<br/>attachment · ideology · history"] --> C
    CTX["Context<br/>issues · evaluations · campaign-time information"] --> S

    C --> EP["Electoral potential"]
    C --> O["Party overlap"]
```

The placement of explanatory variables is empirical rather than mechanically fixed.

---

# S5. Transition matrix

```mermaid
flowchart LR
    A1["Party A at t-1"] -->|"T_AA retention"| A2["Party A at t"]
    A1 -->|"T_AB"| B2["Party B at t"]
    B1["Party B at t-1"] -->|"T_BA"| A2
    B1 -->|"T_BB retention"| B2
    A1 -->|"T_A0"| N2["Abstain / other"]
    B1 -->|"T_B0"| N2
```

Directional transition is preserved. A↔B is not assumed symmetric.

---

# S6. Overlap versus transition versus ideology

```mermaid
flowchart TB
    P["Party pair p,q"]

    P --> O["Consideration overlap O_pq"]
    P --> T["Directional transitions T_pq and T_qp"]
    P --> I["Ideological distance D_IDEO"]

    O --> COMP["Comparative proximity profile"]
    T --> COMP
    I --> COMP

    COMP --> R["Residual / mismatch between behavioural and ideological structure"]
```

---

# S7. Latent-state engine

```mermaid
stateDiagram-v2
    [*] --> Z1
    Z1 --> Z1
    Z1 --> Z2
    Z1 --> Z3
    Z2 --> Z1
    Z2 --> Z2
    Z2 --> Z3
    Z3 --> Z1
    Z3 --> Z2
    Z3 --> Z3

    note right of Z1
      Z1/Z2/Z3 are statistical states.
      Core/Sphere/Periphery labels
      are assigned only after validation.
    end note
```

Observed indicators:

```mermaid
flowchart LR
    Z["Latent state Z_t"] --> PID["PID / strength"]
    Z --> PTV["PTV"]
    Z --> C["Consideration"]
    Z --> V["Vote persistence"]
    Z --> CER["Certainty / decision timing"]
    Z --> NZ["Z_t+1"]
```

---

# S8. Political terrain representation

```text
┌───────────────────────────────────────────────────────────────┐
│                  ELECTORAL-POTENTIAL FIELD                    │
│                                                               │
│        ┌────────────────────────────────────────────┐         │
│        │          HIGH CONSIDERATION FIELD          │         │
│        │                                            │         │
│        │             ┌────────────────┐             │         │
│        │             │ HIGH ATTACHMENT│             │         │
│        │             │ / PERSISTENCE  │             │         │
│        │             └────────────────┘             │         │
│        │                                            │         │
│        └────────────────────────────────────────────┘         │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

This is the cartographic origin of the HSm “city / suburb / periphery” metaphor. The contours are generated from data/model estimates rather than assumed in advance.

---

# S9. Multi-scale geography

```mermaid
flowchart TB
    SA["Small statistical areas / grid"]
    PD["Polling districts"]
    M["Municipalities"]
    C["Constituencies"]
    R["County / Region"]
    N["Nation"]
    F["Derived functional political fields"]

    SA <--> PD
    SA --> M
    PD --> M
    M --> C
    M --> R
    C --> N
    R --> N

    SA --> F
    PD --> F
    M -. "administrative overlay" .-> F
```

---

# S10. Geometry-version crosswalk

```mermaid
flowchart LR
    G1["Geometry at t1"] --> X["Versioned crosswalk"]
    G2["Geometry at t2"] --> X
    G3["Geometry at t3"] --> X

    POP["Population / electorate / address-point weights"] --> X

    X --> CG["Comparison geography"]
    X --> UNC["Crosswalk uncertainty"]
```

---

# S11. MRP small-area estimation

```mermaid
flowchart TB
    S["Survey/panel microdata"] --> MM["Multilevel model"]
    P["Population cell counts"] --> PS["Poststratification"]
    MM --> PS
    E["Known aggregate totals<br/>optional calibration"] -.-> PS

    PS --> EST["Small-area posterior"]
    EST --> U["Credible intervals / quality flags"]
    EST --> GIS["GIS surface"]
```

---

# S12. Spatial analytics ladder

```mermaid
flowchart LR
    MAP["Mapped quantity"] --> GI["Global Moran's I"]
    GI --> LISA["Local Moran / LISA"]
    LISA --> GO["Getis–Ord"]
    GO --> SR["Spatial regression / CAR-ICAR"]
    SR --> ST["Spatiotemporal model"]
    ST --> DH["Diffusion hypothesis"]

    DH -. "does not by itself establish" .-> CONT["Interpersonal contagion"]
```

---

# S13. Ideology and behavioural geography

```mermaid
flowchart LR
    CHES["Party positions<br/>CHES / other source"] --> DI["D_IDEO"]
    SELF["Voter self-placement"] --> DI

    C["Consideration overlap"] --> DB["D_BEHAV"]
    T["Voter transitions"] --> DB
    PTV["PTV proximity"] --> DB

    DI --> R["Ideology-behaviour residual"]
    DB --> R

    R --> GIS["Residual map / network"]
```

---

# S14. Issue plug-in

```mermaid
flowchart TB
    SAL["Issue salience"] --> Q["Issue module q"]
    POS["Voter / party issue position"] --> Q
    OWN["Issue ownership"] --> Q

    Q --> A["Attachment relationship"]
    Q --> C["Consideration relationship"]
    Q --> EP["Potential relationship"]
    Q --> T["Transition relationship"]
    Q --> G["Geographic relationship"]
    Q --> TIME["Temporal relationship"]
```

---

# S15. Space-time cube

```mermaid
flowchart LR
    GT1["g · t1"] --> GT2["g · t2"] --> GT3["g · t3"] --> GT4["g · t4"]
```

Each location-time cell may contain:

```text
vote_share
attachment_estimate
ptv_mean
consideration_probability
electoral_potential
overlap_metrics
transition_metrics
ideology_metrics
issue_metrics
spatial_effect
uncertainty
source_lineage
model_run_id
```

---

# S16. Functional political fields

```mermaid
flowchart TB
    A["Attachment surface"] --> F["Feature matrix by geographic unit"]
    EP["Potential surface"] --> F
    O["Overlap profile"] --> F
    T["Transition profile"] --> F
    I["Ideology"] --> F
    W["Spatial adjacency / network"] --> CL["Spatially constrained clustering"]
    F --> CL

    CL --> PF["Functional political fields"]
    ADMIN["Municipal / constituency borders"] -. "comparison overlay" .-> PF
```

---

# S17. Historical reconstruction

```mermaid
flowchart LR
    E1["Election t1"] --> M1["Politent state t1"]
    M1 --> E2["Election t2"]
    E2 --> M2["Politent state t2"]
    M2 --> E3["Election t3"]
    E3 --> M3["Politent state t3"]

    Q1["Data-quality grade"] --> M1
    Q2["Data-quality grade"] --> M2
    Q3["Data-quality grade"] --> M3
```

---

# S18. Validation loop

```mermaid
flowchart TB
    D["Data snapshot"] --> M["Model specification"]
    M --> O["Estimates"]
    O --> PP["Diagnostics / posterior predictive checks"]
    PP --> H["Temporal/geographic holdout"]
    H --> C{"Calibration adequate?"}

    C -->|"No"| R["Revise model"]
    R --> M

    C -->|"Yes"| S["Sensitivity analysis"]
    S --> P["Publish estimate + uncertainty + provenance"]
```

---

# S19. Epistemic-state flow

```mermaid
flowchart LR
    O["OBSERVED"] --> E["ESTIMATED"]
    E --> D["DERIVED"]
    D --> H["HYPOTHESIS TEST"]
    H --> S["SCENARIO / SENSITIVITY"]

    S -. "must never be relabelled as" .-> O
```

---

# S20. Politent boundary

```mermaid
flowchart LR
    DESC["Descriptive analysis"] --> INF["Statistical inference"]
    INF --> SENS["Sensitivity / scenario analysis"]

    SENS -. "not automatic" .-> CAUS["Causal claim"]
    SENS -. "not" .-> PRED["Election-winner prediction"]
    SENS -. "not" .-> TARGET["Individualized political persuasion"]
```
