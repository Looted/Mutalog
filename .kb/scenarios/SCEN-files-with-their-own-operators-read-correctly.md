---
title: Files with their own operators read correctly
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:30.568Z'
id: SCEN-files-with-their-own-operators-read-correctly
type: scenario
---
Given a fixture that declares and imports operators, when the user lists its mutants with --check, then mutants are found and every one re-reads as intended.

## Context

Checked end to end by `e2e:reads_custom_operators_and_syntax`, which runs Mutalog as a separate process.
