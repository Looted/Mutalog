---
title: A run where most mutants do not load fails the break threshold
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:18.579Z'
id: SCEN-a-run-where-most-mutants-do-not-load-fails-the-break-threshold
type: scenario
---
Given a project in which one module throws whenever it is loaded again, so most mutants do not load, when the user runs mutalog run with break(50), then the run exits with 1, the output lists the compile errors with the first load error, and the JSON report gives that error as statusReason.

## Context

Checked by `e2e:mostly_compile_errors_fails_the_break`.