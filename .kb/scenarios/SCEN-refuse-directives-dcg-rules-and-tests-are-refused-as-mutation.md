---
title: Directives, DCG rules and tests are refused as mutation sites
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:30.274Z'
id: SCEN-refuse-directives-dcg-rules-and-tests-are-refused-as-mutation
type: scenario
---
Given a module with a directive, a DCG rule, an ordinary clause and a begin_tests block, when the user lists its mutants, then the directive, the DCG rule and the test block yield none: every mutant comes from the ordinary clause.

## Context

Failure side of REQ-AUTO-F237B3AAC9F552A2. Checked end to end by `e2e:never_mutates_directives_dcg_or_tests`.
