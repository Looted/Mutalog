---
title: The installed pack loads nothing outside SWI-Prolog
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:03.155Z'
id: SCEN-refuse-the-installed-pack-loads-nothing-outside-swi-prolog
type: scenario
---
Given the installed pack, when library(mutalog) is loaded in a fresh swipl, then no file outside the SWI-Prolog sources is loaded from the pack, and pack.pl requires no other pack.

## Context

Failure side of REQ-AUTO-674E6097A8013135. Checked end to end by `e2e:pack_needs_only_swi_prolog`.
