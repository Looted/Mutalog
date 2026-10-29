---
title: Directives, DCG rules and tests are never mutated
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:29.434Z'
id: SCEN-directives-dcg-rules-and-tests-are-never-mutated
type: scenario
---
Given a module with a directive, a DCG rule, a clause and a begin_tests block, when the user lists its mutants, then they all come from the one ordinary clause.

## Context

Checked end to end by `e2e:never_mutates_directives_dcg_or_tests`, which runs Mutalog as a separate process.
