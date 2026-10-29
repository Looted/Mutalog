---
title: The arith operator swaps arithmetic operators
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:18.833Z'
id: SCEN-the-arith-operator-swaps-arithmetic-operators
type: scenario
---
Given the sample fixture, when the user lists arith mutants, then S0 + H becomes S0 - H.

## Context

Checked end to end by `e2e:operator_arith`, which runs Mutalog as a separate process.
