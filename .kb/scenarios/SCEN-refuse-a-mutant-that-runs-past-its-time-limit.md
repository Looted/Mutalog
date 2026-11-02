---
title: A mutant that runs past its time limit is stopped
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T12:17:06.575Z'
id: SCEN-refuse-a-mutant-that-runs-past-its-time-limit
type: scenario
---
Given the example project and --timeout-ms 300, when a mutant makes countdown/1 loop past its limit, then the runner stops it, reports it as Timeout, and the run still finishes promptly.

## Context

Failure side of REQ-AUTO-5F23006427EE8FC8. Checked by `e2e:time_limit_from_dry_run`.
