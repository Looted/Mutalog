---
title: Packaging must keep Mutalog pure SWI-Prolog with no Node dependency.
status: open
text_ref: plan:open-decisions/language-of-the-tool
tags:
  - strict-modeling
  - confidence:0.82
  - confidence-band:medium
  - provenance:plan-open-decisions-language-of-the-tool
  - lane:strict
semantic_text: Packaging must keep Mutalog pure SWI-Prolog with no Node dependency.
logic_claims:
  - CLAIM-BDE1D5CCE8BF84EC
semantic_clauses:
  - Packaging must keep Mutalog pure SWI-Prolog with no Node dependency.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 3073a2f9593d5f239ab4ad027142b2c6800d315ba78b56d1df6358c6f6064e5a
semantic_inventory:
  - claim_key: CLAIM-BDE1D5CCE8BF84EC
    claim_text: Packaging must keep Mutalog pure SWI-Prolog with no Node dependency
    role: normative
    status: modeled
    span:
      start: 0
      end: 67
rationale: Prolog users can install it without the Node ecosystem.
origin:
  kind: import
  ref: plan:open-decisions/language-of-the-tool
  recorded_at: '2026-10-29T16:05:41.530Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-E3EDF783E91FB673
type: req
---
Packaging must keep Mutalog pure SWI-Prolog with no Node dependency.

## Context

Prolog users can install it without the Node ecosystem.

## Source

> Recommended: pure SWI-Prolog, as planned above, so the pack has no Node dependency and Prolog users can install it with pack_install.

Source: Mutalog design plan: first draft - open-decisions/language-of-the-tool
