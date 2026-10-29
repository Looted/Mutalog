---
title: Mutants apply to static code by reloading the source
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:38.808Z'
id: SCEN-mutants-apply-to-static-code-by-reloading-the-source
type: scenario
---
Given the example project, whose module is static, when the user runs mutalog run, then a mutant of sum/2 is killed and the source file on disk is unchanged.

## Context

Checked end to end by `e2e:applies_mutants_to_static_code`, which runs Mutalog as a separate process.
