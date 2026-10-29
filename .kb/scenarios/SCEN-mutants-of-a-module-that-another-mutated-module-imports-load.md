---
title: Mutants of a module that another mutated module imports load
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T19:05:45.259Z'
id: SCEN-mutants-of-a-module-that-another-mutated-module-imports-load
type: scenario
---
Given a project where module b imports module a and both are mutated, when the user runs mutalog run with one worker, then every mutant loads and is killed, the output has no compile errors and the exit code is 0.

## Context

Checked by `e2e:mutates_a_module_another_module_imports`.