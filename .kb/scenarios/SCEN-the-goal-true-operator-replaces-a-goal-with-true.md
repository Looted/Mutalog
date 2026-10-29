---
title: The goal_true operator replaces a goal with true
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:23.859Z'
id: SCEN-the-goal-true-operator-replaces-a-goal-with-true
type: scenario
---
Given the sample fixture, when the user lists goal_true mutants, then body goals such as total(T, S0) become true.

## Context

Checked end to end by `e2e:operator_goal_true`, which runs Mutalog as a separate process.
