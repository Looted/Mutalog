---
title: The pack has no Node dependency
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:50.838Z'
id: SCEN-the-pack-has-no-node-dependency
type: scenario
---
Given the pack files, then they hold only Prolog, the HTML template and the shell wrapper, with no package.json, and the wrapper never calls node or npm.

## Context

Checked end to end by `e2e:pack_has_no_node_dependency`, which runs Mutalog as a separate process.
