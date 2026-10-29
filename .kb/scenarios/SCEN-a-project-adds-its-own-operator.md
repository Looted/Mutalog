---
title: A project adds its own operator
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:28.380Z'
id: SCEN-a-project-adds-its-own-operator
type: scenario
---
Given a project that defines mutalog:operator/2 and mutalog:mutate/4 clauses for always_true, when it runs mutalog list with --operators always_true, then every mutant comes from that operator.

## Context

Checked end to end by `e2e:custom_operator_from_a_project`, which runs Mutalog as a separate process.
