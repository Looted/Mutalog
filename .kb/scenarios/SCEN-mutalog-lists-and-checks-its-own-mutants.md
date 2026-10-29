---
title: Mutalog lists and checks its own mutants
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:31.559Z'
id: SCEN-mutalog-lists-and-checks-its-own-mutants
type: scenario
---
Given the Mutalog checkout, whose tests run with plunit, when the user runs mutalog list on prolog/**/*.pl with --check, then every mutant of Mutalog itself re-reads correctly.

## Context

Checked end to end by `e2e:mutates_itself`, which runs Mutalog as a separate process.
