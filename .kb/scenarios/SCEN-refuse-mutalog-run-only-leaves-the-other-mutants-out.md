---
title: mutalog run --only leaves the other mutants out
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:31:59.712Z'
id: SCEN-refuse-mutalog-run-only-leaves-the-other-mutants-out
type: scenario
---
Given the example project and one mutant id, when the user runs mutalog run --only with that id, then no other mutant runs: the report holds that mutant alone.

## Context

Failure side of REQ-AUTO-5C0604494F0458D4. Checked end to end by `e2e:only_runs_the_chosen_mutants`.
