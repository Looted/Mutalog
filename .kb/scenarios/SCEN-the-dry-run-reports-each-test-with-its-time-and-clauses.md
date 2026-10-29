---
title: The dry run reports each test with its time and clauses
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:33.527Z'
id: SCEN-the-dry-run-reports-each-test-with-its-time-and-clauses
type: scenario
---
Given the example project, when the user runs mutalog dry-run, then each test is listed with its time in milliseconds and the number of clauses it entered, and the summary counts 7 tests and 55 mutants.

## Context

Checked end to end by `e2e:dry_run_records_time_and_clauses`, which runs Mutalog as a separate process.
