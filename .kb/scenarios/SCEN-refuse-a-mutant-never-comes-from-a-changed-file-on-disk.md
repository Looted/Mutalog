---
title: A mutant never comes from a changed file on disk
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:33:17.311Z'
id: SCEN-refuse-a-mutant-never-comes-from-a-changed-file-on-disk
type: scenario
---
Given the example project, whose module is static, when the user runs mutalog run, then no mutant is written to disk to be loaded: a mutant of sum/2 is killed and the source file on disk is byte for byte unchanged.

## Context

Failure side of REQ-AUTO-2919CA799C575688. Checked end to end by `e2e:applies_mutants_to_static_code`.
