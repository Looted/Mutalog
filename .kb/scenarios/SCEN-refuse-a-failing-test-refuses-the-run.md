---
title: A failing test refuses the run
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:31:49.063Z'
id: SCEN-refuse-a-failing-test-refuses-the-run
type: scenario
---
Given a project whose own test fails on the unmutated code, when the user runs mutalog run, then Mutalog refuses to judge any mutant: it exits with 2, names the failing test and writes no report.

## Context

Failure side of REQ-AUTO-3FC60457FD45514E. Checked end to end by `e2e:failing_test_stops_the_run`.
