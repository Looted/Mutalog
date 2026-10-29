---
title: The cut operators remove and insert cuts
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:22.818Z'
id: SCEN-the-cut-operators-remove-and-insert-cuts
type: scenario
---
Given the fixtures, when the user lists cut and cut_insert mutants, then a cut becomes true and a cut is inserted after the first goal of a non-last clause without one.

## Context

Checked end to end by `e2e:operator_cut`, which runs Mutalog as a separate process.
