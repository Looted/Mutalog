---
title: A clause that a mutant drops stops answering after the reload
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:24.572Z'
id: SCEN-a-clause-that-a-mutant-drops-stops-answering-after-the-reload
type: scenario
---
Given a module that is reloaded over a previous version of itself, the way the worker applies one mutant after another, when a clause that ran after the first reload is dropped by the second, then calls no longer reach the dropped clause, checked in several fresh processes.

## Context

Checked by `worker:reload_drops_stale_clauses`, and from the user's side by `e2e:dropped_clause_mutant_is_killed`.