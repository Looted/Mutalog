---
title: Run mutants in reusable child processes
status: accepted
tags:
  - decision
  - runner
origin:
  kind: import
  ref: plan:running-mutants/in-process-or-subprocess
  recorded_at: '2026-10-29T16:05:45.695Z'
id: ADR-runner-child-process-workers
type: adr
---
## Context

Projects under test can write temp directories, open stores and spawn processes, and a runaway mutant can exhaust the stack or heap of the whole process. Running mutants on threads inside the controller would be fastest but unsafe.

## Decision

Every mutant runs in a child swipl worker. A worker loads the project once and then takes mutants one after another, so the per-mutant cost is the test time plus the reload. Workers start with a stack limit (stack_limit, default 1g).

## Consequences

Non-hermetic test suites are safe to mutate. A crashed or hung worker is replaced without losing the run.
