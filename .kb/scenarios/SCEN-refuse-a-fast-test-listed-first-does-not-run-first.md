---
title: A fast test listed first does not run first
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:17.069Z'
id: SCEN-refuse-a-fast-test-listed-first-does-not-run-first
type: scenario
---
Given one worker and a fast test listed before a slow one, when the user runs mutalog run, then the fast test does not start first: the slow test's mutants run before it.

## Context

Failure side of REQ-AUTO-C6895C0B44964BBF. Checked end to end by `e2e:longest_limits_start_first`.
