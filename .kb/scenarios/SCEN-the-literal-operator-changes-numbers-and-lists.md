---
title: The literal operator changes numbers and lists
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:27.258Z'
id: SCEN-the-literal-operator-changes-numbers-and-lists
type: scenario
---
Given the sample fixture, when the user lists literal mutants, then 10 becomes 11 and -10, [] becomes [_] and 0 becomes 1.

## Context

Checked end to end by `e2e:operator_literal`, which runs Mutalog as a separate process.
