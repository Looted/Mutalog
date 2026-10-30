---
title: Release must publish the version in pack.pl when a push to master carries a version that has no tag.
status: open
text_ref: readme:README.md#L183
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - lane:strict
semantic_text: Release must publish the version in pack.pl when a push to master carries a version that has no tag.
logic_claims:
  - CLAIM-2FAB61E2DF9A414C
semantic_clauses:
  - Release must publish the version in pack.pl when a push to master carries a version that has no tag.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 200b6800b7266dad3b6246ab229f9037eccac04765dca2a937b05c1b05245ab2
semantic_inventory:
  - claim_key: CLAIM-2FAB61E2DF9A414C
    claim_text: Release must publish the version in pack.pl when a push to master carries a version that has no tag
    role: normative
    status: modeled
    span:
      start: 0
      end: 99
origin:
  kind: import
  ref: readme:README.md#L183
  recorded_at: '2026-10-30T13:57:57.339Z'
firmness: firm
required_evidence: asserted
id: REQ-release-on-merge-to-master
type: req
---
Release must publish the version in pack.pl when a push to master carries a version that has no tag.

## Context

Piotr asked for releases to consume changesets: pull requests add changesets, a release pull request runs `npm run version-packages` to turn them into the next version, and merging it releases that version without a manual workflow run. Pushes whose version is already tagged release nothing.

## Why this changed

It replaces REQ-release-run-workflow-on-master: with changesets the version is decided in the release pull request, so merging it is the release and the manual workflow run is only a retry.

## Source

> 3. Merge it. The **Release** workflow sees a version in `pack.pl` that has no tag, runs CI on the commit, creates the `vX.Y.Z` tag and GitHub release with the changelog section as notes, and publishes the pack. On other merges it finds the version already tagged and does nothing.

Source: Mutalog README - Releasing
