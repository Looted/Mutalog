---
title: The release check refuses an already tagged version
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:52.868Z'
id: SCEN-the-release-check-refuses-an-already-tagged-version
type: scenario
---
Given a checkout whose origin has no tag for the version, when release-check.sh --untagged runs it passes; after the tag is pushed, it fails saying the tag already exists.

## Context

Checked end to end by `e2e:release_refuses_a_tagged_version`, which runs Mutalog as a separate process.
