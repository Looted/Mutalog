---
title: Release must refuse to publish when the tag does not match the version in pack.pl.
status: open
text_ref: release:.github/workflows/release.yml#L38
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:release-github-workflows-release-yml-l38
  - lane:strict
semantic_text: Release must refuse to publish when the tag does not match the version in pack.pl.
logic_claims:
  - CLAIM-137B3268E1D35562
semantic_clauses:
  - Release must refuse to publish when the tag does not match the version in pack.pl.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: fa50fac53197e9a6e1b53365b708c7962291b7ba00fa7052240bc28c6f5d3f24
semantic_inventory:
  - claim_key: CLAIM-137B3268E1D35562
    claim_text: Release must refuse to publish when the tag does not match the version in pack.pl
    role: normative
    status: modeled
    span:
      start: 0
      end: 81
rationale: A tag pushed before its version bump merged must not publish a mismatched pack.
origin:
  kind: import
  ref: release:.github/workflows/release.yml#L38
  recorded_at: '2026-10-29T16:05:25.533Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-28A9B0836A0D675D
type: req
---
Release must refuse to publish when the tag does not match the version in pack.pl.

## Context

A tag pushed before its version bump merged must not publish a mismatched pack.

## Source

> test "v$version" = "$GITHUB_REF_NAME"

Source: Release workflow - .github/workflows/release.yml#L38
