---
title: Code that swallows the time limit is stopped
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:10.201Z'
id: SCEN-refuse-code-that-swallows-the-time-limit-is-stopped
type: scenario
---
Given code that catches the worker time limit and loops again, when the user runs mutalog run, then the controller stops it at the hard limit: the mutant is Timeout and the run finishes.

## Context

Failure side of REQ-AUTO-A94EF4A2296AFF54. Checked end to end by `e2e:hard_limit_stops_a_swallowed_time_limit`.
