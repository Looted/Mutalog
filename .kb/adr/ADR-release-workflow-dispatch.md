---
title: Publish releases from a workflow run on master
status: superseded
tags:
  - decision
  - release
origin:
  kind: import
  ref: readme:README.md#L156
  recorded_at: '2026-10-29T16:10:47.345Z'
id: ADR-release-workflow-dispatch
type: adr
---
## Context

Releases were published by pushing a vX.Y.Z tag (ADR-release-tag-driven-publishing). A tag pushed before its version bump merged could not be reused, which burned v0.1.0 and v0.1.1.

## Decision

A release bumps pack.pl and adds its CHANGELOG.md section in one pull request; CI fails when the two disagree. After merging, the Release workflow is run on master from the Actions tab. It refuses an already-tagged version, creates the vX.Y.Z tag and GitHub release with the changelog section as notes, and publishes the pack through the lower-case archive URL. Tags are never created by hand.

## Why this changed

The workflow checks the version before a tag exists, so a mistake costs a failed run instead of a burned version number.

## Consequences

Releasing is one button press after the bump merges, and every release has notes.
