---
title: Version and release from changesets
status: accepted
tags:
  - decision
  - release
origin:
  kind: import
  ref: readme:README.md#L177
  recorded_at: '2026-10-30T13:58:57.278Z'
id: ADR-release-changesets
type: adr
---
## Context

Releases bumped pack.pl and wrote a CHANGELOG.md section by hand in one pull request, then someone ran the Release workflow from the Actions tab (ADR-release-workflow-dispatch). Piotr asked for releases to consume changesets instead.

## Decision

Each pull request that changes what users of the pack see adds a changeset under .changeset/. A release pull request runs `npm run version-packages`, which runs `changeset version` on the private root package.json and then scripts/sync-version.mjs, which copies the version into pack.pl and dates and places the new CHANGELOG.md section. CI fails when package.json, pack.pl and CHANGELOG.md disagree. Every push to master runs the Release workflow: when the version in pack.pl has no tag, it runs CI on the commit, creates the vX.Y.Z tag and GitHub release with the changelog section as notes, and publishes the pack; otherwise it does nothing. Running the workflow by hand retries a failed release. Tags are never created by hand.

## Why this changed

Changelog entries are written with the change that causes them, and the bump level is chosen from them, so a release no longer needs someone to collect notes and pick the version, nor a separate manual run after merging.

## Consequences

A release is one pull request: run the version step, review the generated section, merge. Node is needed for the version step only; the pack itself stays pure SWI-Prolog.