---
title: The hard limit stops code that catches the time limit
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:40.781Z'
id: SCEN-the-hard-limit-stops-code-that-catches-the-time-limit
type: scenario
---
Given code that catches every exception and loops again, when the user runs mutalog run, then its mutant is Timeout and the run finishes.

## Context

Checked end to end by `e2e:hard_limit_stops_a_swallowed_time_limit`, which runs Mutalog as a separate process.
