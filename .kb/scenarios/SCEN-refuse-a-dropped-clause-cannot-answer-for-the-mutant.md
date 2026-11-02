---
title: A dropped clause cannot answer for the mutant
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:35:33.514Z'
id: SCEN-refuse-a-dropped-clause-cannot-answer-for-the-mutant
type: scenario
---
Given a module whose ne/1 clause a test needs, when a clause_drop mutant removes that clause after an earlier mutant was loaded, then the stale clause does not answer: the mutant is Killed.

## Context

Failure side of REQ-dropped-clauses-stop-answering. Checked end to end by `e2e:dropped_clause_mutant_is_killed`.
