---
title: The negate operator removes a negation or negates a condition
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:21.817Z'
id: SCEN-the-negate-operator-removes-a-negation-or-negates-a-conditio
type: scenario
---
Given the sample fixture, when the user lists negate mutants, then an if-then-else condition is negated and \+ X == off loses its negation.

## Context

Checked end to end by `e2e:operator_negate`, which runs Mutalog as a separate process.
