---
title: A crashing mutant is not retried past the limit
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:06.596Z'
id: SCEN-refuse-a-crashing-mutant-is-not-retried-past-the-limit
type: scenario
---
Given a project where a mutant halts its worker, when the user runs with retries(0) and then retries(2), then the crashing mutant gets no further attempt with retries(0) and exactly two more with retries(2).

## Context

Failure side of REQ-AUTO-8FA9AE813FAC53CA. Checked end to end by `e2e:crash_is_retried_on_a_fresh_worker`.
