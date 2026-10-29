---
title: The break threshold sets the exit code
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:45.802Z'
id: SCEN-the-break-threshold-sets-the-exit-code
type: scenario
---
Given the example project scoring 67.3%, when break is 90 then mutalog run exits with 1, and when break is 50 it exits with 0.

## Context

Checked end to end by `e2e:break_threshold_sets_the_exit_code`, which runs Mutalog as a separate process.
