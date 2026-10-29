---
title: The goal_fail operator replaces a goal with fail
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:24.964Z'
id: SCEN-the-goal-fail-operator-replaces-a-goal-with-fail
type: scenario
---
Given the sample fixture, when the user lists goal_fail mutants, then body goals such as total(T, S0) become fail.

## Context

Checked end to end by `e2e:operator_goal_fail`, which runs Mutalog as a separate process.
