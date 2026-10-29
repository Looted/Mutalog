---
title: Enforce time limits in the worker and again from the controller
status: accepted
tags:
  - decision
  - runner
  - scheduler
origin:
  kind: agent
  recorded_at: '2026-10-29T16:05:48.302Z'
id: ADR-runner-two-level-time-limits
type: adr
---
## Context

A mutated clause can loop forever or backtrack exponentially. call_with_time_limit/2 in the worker is not enough on its own: code under test can catch time_limit_exceeded and keep looping, and a blocking read on the worker pipe would hang the controller with it.

## Decision

Each mutant gets timeout_factor times its covering tests' dry-run time plus timeout_ms, enforced by the worker. The controller enforces a hard limit 10 seconds later, reads worker pipes without blocking, and kills and replaces a worker that misses it.

## Consequences

A runaway mutant is always settled as timeout and the pool keeps going. Timeouts are not retried, because a timeout already counts as detected.
