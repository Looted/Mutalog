---
title: A crashing mutant is retried on a fresh worker
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:42.684Z'
id: SCEN-a-crashing-mutant-is-retried-on-a-fresh-worker
type: scenario
---
Given a project where a mutant halts its worker, when the user runs with retries(2) instead of retries(0), then each crashing mutant is attempted two more times.

## Context

Checked end to end by `e2e:crash_is_retried_on_a_fresh_worker`, which runs Mutalog as a separate process.
