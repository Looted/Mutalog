---
title: A mutant does not run tests that never entered it
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:26.960Z'
id: SCEN-refuse-a-mutant-does-not-run-tests-that-never-entered-it
type: scenario
---
Given the example project, when the user runs mutalog run, then the mutant in sum/2 is covered and killed by calc:sum only, and no other test is run against it.

## Context

Failure side of REQ-AUTO-ECC62318E485FD92. Checked end to end by `e2e:runs_only_covering_tests`.
