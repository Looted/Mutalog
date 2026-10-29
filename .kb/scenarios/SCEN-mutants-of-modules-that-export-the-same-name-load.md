---
title: Mutants of modules that export the same name load
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:12.378Z'
id: SCEN-mutants-of-modules-that-export-the-same-name-load
type: scenario
---
Given a project with two mutated modules that both export f/2, when the user runs mutalog run with one worker, then every mutant of both modules loads and is killed and the exit code is 0.

## Context

Checked by `e2e:mutates_modules_that_export_the_same_name`.