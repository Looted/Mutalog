---
title: A spliced mutant that reads back differently is reported
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T12:17:12.393Z'
id: SCEN-refuse-a-spliced-mutant-that-reads-back-differently
type: scenario
---
Given a project with a custom operator whose mutant prints as text that reads back as a different clause, when the user runs mutalog list --check --format json, then every such mutant reports a mismatch and the command exits 1.

## Context

Failure side of REQ-AUTO-8EAA6C05E83E19E8. Checked end to end by `e2e:list_check_reports_a_mutant_that_reads_back_differently`.
