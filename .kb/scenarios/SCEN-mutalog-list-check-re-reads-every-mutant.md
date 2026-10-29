---
title: mutalog list --check re-reads every mutant
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:16.743Z'
id: SCEN-mutalog-list-check-re-reads-every-mutant
type: scenario
---
Given the example project, when the user runs mutalog list --check --format json, then all 55 mutants report check ok.

## Context

Checked end to end by `e2e:list_check_rereads_every_mutant`, which runs Mutalog as a separate process.
