---
title: The compare operator moves and flips comparisons
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:19.831Z'
id: SCEN-the-compare-operator-moves-and-flips-comparisons
type: scenario
---
Given the sample fixture, when the user lists compare mutants, then X < 10 becomes X =< 10 and X >= 10, and X >= 10 becomes X > 10 and X < 10.

## Context

Checked end to end by `e2e:operator_compare`, which runs Mutalog as a separate process.
