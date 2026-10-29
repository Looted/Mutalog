---
title: mutalog run --only runs the chosen mutants
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:44.763Z'
id: SCEN-mutalog-run-only-runs-the-chosen-mutants
type: scenario
---
Given the example project, when the user runs mutalog run --only with one mutant id, then the report holds just that mutant, killed.

## Context

Checked end to end by `e2e:only_runs_the_chosen_mutants`, which runs Mutalog as a separate process.
