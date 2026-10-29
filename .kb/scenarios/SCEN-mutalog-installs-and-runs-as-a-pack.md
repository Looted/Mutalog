---
title: Mutalog installs and runs as a pack
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:48.860Z'
id: SCEN-mutalog-installs-and-runs-as-a-pack
type: scenario
---
Given the pack files of the checkout, when they are installed with pack_install into an empty pack directory, then library(mutalog) runs mutalog list on the example project.

## Context

Checked end to end by `e2e:installs_as_a_pack`, which runs Mutalog as a separate process.
