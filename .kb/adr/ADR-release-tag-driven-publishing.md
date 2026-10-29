---
title: Publish releases by pushing a version tag
status: superseded
tags:
  - decision
  - release
origin:
  kind: import
  ref: release:.github/workflows/release.yml#L3
  recorded_at: '2026-10-29T16:05:51.974Z'
id: ADR-release-tag-driven-publishing
type: adr
---
## Context

The development sandbox cannot reach swi-prolog.org, so publishing must happen in CI. The first attempts showed two traps: SWI-Prolog takes the pack name from the archive URL path and refuses a case mismatch with pack.pl, and a tag pushed before its version bump merged publishes the wrong version. Tags v0.1.0 and v0.1.1 were burned this way; v0.1.2 is the first real release.

## Decision

Pushing a tag vX.Y.Z runs the release workflow, which checks the tag against pack.pl, registers the lower-case archive URL with the pack server, then installs the pack by name and runs the example project. The version bump is always merged to master before the tag is created.

## Consequences

A release is one tag push from the GitHub UI. A mismatched tag fails the workflow without publishing.
