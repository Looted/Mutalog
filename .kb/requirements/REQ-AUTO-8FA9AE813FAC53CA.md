---
title: Scheduler must retry a mutant that crashes its worker on a fresh worker up to retries times.
status: open
text_ref: readme:README.md#L136
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:readme-readme-md-l136
  - lane:strict
semantic_text: Scheduler must retry a mutant that crashes its worker on a fresh worker up to retries times.
logic_claims:
  - CLAIM-12166E6F004544B7
semantic_clauses:
  - Scheduler must retry a mutant that crashes its worker on a fresh worker up to retries times.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 17a2812962b7f7252c69758bffcf4682c122d2ae26a8a37f245c7c38b5e6016e
semantic_inventory:
  - claim_key: CLAIM-12166E6F004544B7
    claim_text: Scheduler must retry a mutant that crashes its worker on a fresh worker up to retries times
    role: normative
    status: modeled
    span:
      start: 0
      end: 91
origin:
  kind: import
  ref: readme:README.md#L136
  recorded_at: '2026-10-29T16:05:34.615Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-8FA9AE813FAC53CA
type: req
---
Scheduler must retry a mutant that crashes its worker on a fresh worker up to retries times.

## Source

> A mutant that crashes its worker is tried again on a fresh worker, up to `retries` times.

Source: Mutalog README - README.md#L136
