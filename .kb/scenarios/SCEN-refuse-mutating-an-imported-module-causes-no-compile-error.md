---
title: Mutating an imported module causes no compile error
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:35:40.295Z'
id: SCEN-refuse-mutating-an-imported-module-causes-no-compile-error
type: scenario
---
Given module b importing module a, both mutated, when the user runs mutalog run, then no mutant of a fails to load: there are no compile errors and every mutant is Killed.

## Context

Failure side of REQ-mutants-of-imported-modules-load. Checked end to end by `e2e:mutates_a_module_another_module_imports`.
