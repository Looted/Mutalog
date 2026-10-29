---
title: The clause_drop operator removes one clause
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:26.075Z'
id: SCEN-the-clause-drop-operator-removes-one-clause
type: scenario
---
Given the sample fixture, when the user lists clause_drop mutants, then each of the 4 clauses of multi-clause predicates is replaced by nothing.

## Context

Checked end to end by `e2e:operator_clause_drop`, which runs Mutalog as a separate process.
