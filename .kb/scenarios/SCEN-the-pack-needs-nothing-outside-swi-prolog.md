---
title: The pack needs nothing outside SWI-Prolog
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:49.817Z'
id: SCEN-the-pack-needs-nothing-outside-swi-prolog
type: scenario
---
Given the installed pack, when library(mutalog) is loaded in a fresh swipl, then every file it loads from the pack is Prolog source and pack.pl requires no other pack.

## Context

Checked end to end by `e2e:pack_needs_only_swi_prolog`, which runs Mutalog as a separate process.
