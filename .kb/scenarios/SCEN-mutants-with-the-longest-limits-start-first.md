---
title: Mutants with the longest limits start first
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:43.682Z'
id: SCEN-mutants-with-the-longest-limits-start-first
type: scenario
---
Given one worker and a slow test listed after a fast one, when the user runs mutalog run, then the slow test's mutants run before the fast test's.

## Context

Checked end to end by `e2e:longest_limits_start_first`, which runs Mutalog as a separate process.
