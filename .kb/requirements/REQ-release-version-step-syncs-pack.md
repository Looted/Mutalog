---
title: The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction.
status: open
text_ref: readme:README.md#L182
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - lane:strict
semantic_text: The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction.
logic_claims:
  - CLAIM-17DB9B8D395EACE8
semantic_clauses:
  - The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 155422385d9f9e7da3a9531286e043e6b1d4edb7d93a9f9a8f866e139235c8d0
semantic_inventory:
  - claim_key: CLAIM-17DB9B8D395EACE8
    claim_text: The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction
    role: normative
    status: modeled
    span:
      start: 0
      end: 136
origin:
  kind: import
  ref: readme:README.md#L182
  recorded_at: '2026-10-30T13:58:09.947Z'
firmness: firm
required_evidence: asserted
id: REQ-release-version-step-syncs-pack
type: req
---
The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction.

## Context

Piotr asked for releases to consume changesets. Changesets bumps package.json and writes its section directly under the changelog title with "### Patch Changes" style headings, while the pack's version lives in pack.pl and the existing sections are dated plain bullet lists. `npm run version-packages` runs scripts/sync-version.mjs after `changeset version` so the three files agree and the release notes keep their layout.

## Source

> 2. To release, run `npm run version-packages` in a pull request. It consumes the pending changesets, bumps the version in `package.json` and `pack.pl`, and writes a dated `## X.Y.Z` section of `CHANGELOG.md` from them. CI fails if the three disagree.

Source: Mutalog README - Releasing