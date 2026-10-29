---
title: Mutants no test covers are settled without running
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:36.713Z'
id: SCEN-mutants-no-test-covers-are-settled-without-running
type: scenario
---
Given the example project, when the user runs mutalog run, then the mutant in unused/1 is NoCoverage with no covering or killing tests.

## Context

Checked end to end by `e2e:uncovered_mutants_are_not_run`, which runs Mutalog as a separate process.
