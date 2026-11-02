---
title: A run where most mutants do not load fails the break
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:35:36.837Z'
id: SCEN-refuse-a-run-where-most-mutants-do-not-load-fails-the-break
type: scenario
---
Given a project where most mutants fail to load and break is 50, when the user runs mutalog run, then the run fails with exit status 1 and reports the compile errors.

## Context

Failure side of REQ-mostly-compile-errors-fail-break. Checked end to end by `e2e:mostly_compile_errors_fails_the_break`.
