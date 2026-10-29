---
title: mutalog list prints the mutants and runs nothing
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:15.675Z'
id: SCEN-mutalog-list-prints-the-mutants-and-runs-nothing
type: scenario
---
Given the example project, when the user runs mutalog list, then every mutant is printed with its change and no report directory is created, because no test ran.

## Context

Checked end to end by `e2e:list_prints_mutants_without_running`, which runs Mutalog as a separate process.
