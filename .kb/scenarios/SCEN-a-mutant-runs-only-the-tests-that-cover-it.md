---
title: A mutant runs only the tests that cover it
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:37.720Z'
id: SCEN-a-mutant-runs-only-the-tests-that-cover-it
type: scenario
---
Given the example project, when the user runs mutalog run, then the mutant in sum/2 is killed by calc:sum and covered by calc:sum only.

## Context

Checked end to end by `e2e:runs_only_covering_tests`, which runs Mutalog as a separate process.
