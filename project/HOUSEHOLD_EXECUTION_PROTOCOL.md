# Politent — Household Family Execution Protocol

**Protocol ID:** POL-HH-001  
**Status:** ACTIVE  
**Activated:** 2026-09-30  
**Scope:** Politent four-phase implementation programme

## Purpose

The FFOS Household Family is used as the execution-support pattern for Politent Work Packages (WPs).

The Household layer adds **orchestration only**. It does not change Politent's scientific authority model, estimands, validation rules, or source requirements.

## Roles

### Director
Owns progression control. For every WP the Director checks dependencies, confirms source/data readiness, dispatches bounded work, checks acceptance criteria, blocks downstream progression when a gate fails, and records acceptance or rejection.

### Janitor
Owns hygiene and drift detection. Scans for broken provenance, stale source references, contradictory files, undocumented manual GIS edits, schema drift, geometry/version mismatch, epistemic-state confusion, and untracked uncertainty.

### Handyman
Owns bounded deterministic repair. May repair schemas, manifests, paths/names, broken QGIS joins/config, metadata, and deterministic validation failures. May not invent missing data, relax a scientific gate, convert estimates into observations, or change substantive model definitions without Director review.

### Household Controller
Runs the sequence:

Janitor → Handyman → Re-scan → Director

No WP is accepted while a blocking finding remains.

## WP lifecycle

STAGED → READY → ACTIVE → REVIEW → ACCEPTED

Blocking alternatives: BLOCKED, REPAIR, REJECTED.

## Required evidence per WP

Each WP must produce source/dependency evidence, changed files, model/code/config version where relevant, validation result, open findings, and Director decision.

## Phase rule

A downstream WP may be prepared, but not accepted before all hard dependencies are accepted.

## Scientific hard gates

Household cannot override source availability, dataset restrictions, uncertainty requirements, MAUP checks, latent-state validation, ecological-inference boundaries, privacy/disclosure rules, or Politent epistemic-state rules.

## Execution order

Phase I → Phase II → Phase III → Phase IV.

Maximum five WPs per phase.

The canonical manifest is `project/WP_MANIFEST.yml`.