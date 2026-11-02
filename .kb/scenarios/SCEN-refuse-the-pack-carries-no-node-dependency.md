---
title: The pack carries no Node dependency
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:23.724Z'
id: SCEN-refuse-the-pack-carries-no-node-dependency
type: scenario
---
Given the pack files, then they contain no package.json and the bin/mutalog wrapper never calls node or npm.

## Context

Failure side of REQ-AUTO-E3EDF783E91FB673. Checked end to end by `e2e:pack_has_no_node_dependency`.
