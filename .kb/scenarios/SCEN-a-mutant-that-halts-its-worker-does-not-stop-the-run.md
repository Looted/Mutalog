---
title: A mutant that halts its worker does not stop the run
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:41.705Z'
id: SCEN-a-mutant-that-halts-its-worker-does-not-stop-the-run
type: scenario
---
Given a project where one mutant calls halt/1, when the user runs mutalog run, then that mutant is RuntimeError, the other mutants are still judged and the run exits normally.

## Context

Checked end to end by `e2e:crash_is_isolated_in_a_worker_process`, which runs Mutalog as a separate process.
