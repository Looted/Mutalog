---
title: The unify operator swaps unification and equality tests
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:20.811Z'
id: SCEN-the-unify-operator-swaps-unification-and-equality-tests
type: scenario
---
Given the sample fixture, when the user lists unify mutants, then Value = none becomes Value \= none and X == off becomes X \== off.

## Context

Checked end to end by `e2e:operator_unify`, which runs Mutalog as a separate process.
