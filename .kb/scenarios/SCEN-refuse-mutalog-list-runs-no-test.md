---
title: mutalog list runs no test
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:31:56.413Z'
id: SCEN-refuse-mutalog-list-runs-no-test
type: scenario
---
Given the example project, when the user runs mutalog list, then no test runs: the mutants are printed and no report directory appears.

## Context

Failure side of REQ-AUTO-5245DE11724348A5. Checked end to end by `e2e:list_prints_mutants_without_running`.
