---
title: CI must fail when the version in pack.pl has no matching section in CHANGELOG.md.
status: open
text_ref: readme:README.md#L158
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - lane:strict
semantic_text: CI must fail when the version in pack.pl has no matching section in CHANGELOG.md.
logic_claims:
  - CLAIM-59378A68EEBBC818
semantic_clauses:
  - CI must fail when the version in pack.pl has no matching section in CHANGELOG.md.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: a01de28163ecab2712c282bb87f59d0a80a45a0fb802c4f049a25b8f7ec32d76
semantic_inventory:
  - claim_key: CLAIM-59378A68EEBBC818
    claim_text: CI must fail when the version in pack.pl has no matching section in CHANGELOG.md
    role: normative
    status: modeled
    span:
      start: 0
      end: 80
origin:
  kind: import
  ref: readme:README.md#L158
  recorded_at: '2026-10-29T16:10:39.925Z'
firmness: firm
required_evidence: asserted
id: REQ-release-changelog-matches-pack
type: req
---
CI must fail when the version in pack.pl has no matching section in CHANGELOG.md.

## Context

The version bump and its changelog section land together in one pull request, so the release notes always exist before a release is run.

## Source

> 1. In a pull request, bump `version('X.Y.Z')` in `pack.pl` and add a `## X.Y.Z` section to `CHANGELOG.md`. CI fails if the two disagree.

Source: Mutalog README - README.md#L158
