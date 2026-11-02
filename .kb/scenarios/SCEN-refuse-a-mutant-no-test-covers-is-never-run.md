---
title: A mutant no test covers is never run
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:31:52.790Z'
id: SCEN-refuse-a-mutant-no-test-covers-is-never-run
type: scenario
---
Given the example project, whose unused/1 no test enters, when the user runs mutalog run, then the mutant in unused/1 is not run: it is reported as NoCoverage with no covering or killing tests.

## Context

Failure side of REQ-AUTO-4D6793556060D2C3. Checked end to end by `e2e:uncovered_mutants_are_not_run`.
