---
title: Release must refuse a version that is already tagged.
status: open
text_ref: readme:README.md#L185
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - lane:strict
semantic_text: Release must refuse a version that is already tagged.
logic_claims:
  - CLAIM-A82CD1DFE24DB66F
semantic_clauses:
  - Release must refuse a version that is already tagged.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 4bb2b84d0acb3ccd0cedc32d4341f50e6ad89e4048302fb8b3e80e7347f26a55
semantic_inventory:
  - claim_key: CLAIM-A82CD1DFE24DB66F
    claim_text: Release must refuse a version that is already tagged
    role: normative
    status: modeled
    span:
      start: 0
      end: 52
origin:
  kind: import
  ref: readme:README.md#L185
  recorded_at: '2026-10-29T16:10:35.165Z'
firmness: firm
required_evidence: asserted
id: REQ-release-refuse-tagged-version
type: req
---
Release must refuse a version that is already tagged.

## Context

A tag on a commit whose pack.pl disagrees cannot be reused, so the workflow checks for an existing tag before creating one and publishing.

## Why this changed

PR #9 replaced hand-pushed release tags with a Release workflow run on master, because tags pushed before the version bump merged burned v0.1.0 and v0.1.1.

## Source

> If a release fails, run the **Release** workflow on `master` from the Actions tab to retry it; it refuses a version that is already tagged. Don't create tags or releases by hand: a tag on a commit whose `pack.pl` disagrees can't be reused.

Source: Mutalog README - README.md#L185
