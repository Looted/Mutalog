---
title: A failing test stops the run before any mutant
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:34.598Z'
id: SCEN-a-failing-test-stops-the-run-before-any-mutant
type: scenario
---
Given a project whose test fails on the unmutated code, when the user runs mutalog run, then it exits with 2, names the failing test and writes no report.

## Context

Checked end to end by `e2e:failing_test_stops_the_run`, which runs Mutalog as a separate process.
