---
title: A looping mutant times out
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:39.727Z'
id: SCEN-a-looping-mutant-times-out
type: scenario
---
Given the example project and --timeout-ms 300, when the user runs mutalog run, then the mutant that makes countdown/1 loop is Timeout and the run finishes promptly.

## Context

Checked end to end by `e2e:time_limit_from_dry_run`, which runs Mutalog as a separate process.
