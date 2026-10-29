---
title: Release must publish the version in pack.pl when the Release workflow is run on master.
status: open
text_ref: readme:README.md#L159
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - lane:strict
semantic_text: Release must publish the version in pack.pl when the Release workflow is run on master.
logic_claims:
  - CLAIM-C3A1AEE729795ED3
semantic_clauses:
  - Release must publish the version in pack.pl when the Release workflow is run on master.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: e5951c9754cb2b73b582625e138583b200be830b57fc50dec50fdcfcca9e26b7
semantic_inventory:
  - claim_key: CLAIM-C3A1AEE729795ED3
    claim_text: Release must publish the version in pack.pl when the Release workflow is run on master
    role: normative
    status: modeled
    span:
      start: 0
      end: 86
origin:
  kind: import
  ref: readme:README.md#L159
  recorded_at: '2026-10-29T16:10:31.786Z'
firmness: firm
required_evidence: asserted
id: REQ-release-run-workflow-on-master
type: req
---
Release must publish the version in pack.pl when the Release workflow is run on master.

## Context

Releases moved from hand-pushed tags to a workflow run from the Actions tab, so the tag is created only after the version checks pass. Hand-made tags v0.1.0 and v0.1.1 were burned by publishing before the version bump merged.

## Why this changed

PR #9 replaced hand-pushed release tags with a Release workflow run on master, because tags pushed before the version bump merged burned v0.1.0 and v0.1.1.

## Source

> 2. Merge it, then run the **Release** workflow on `master` from the Actions tab.

Source: Mutalog README - README.md#L159
