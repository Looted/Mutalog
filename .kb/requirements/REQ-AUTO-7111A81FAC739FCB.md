---
title: Project must not name specific downstream or consumer projects in code, tests, docs, CI workflows, commit messages or pull request descriptions.
status: open
text_ref: agents:AGENTS.md#L3
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:agents-agents-md-l3
  - lane:strict
semantic_text: Project must not name specific downstream or consumer projects in code, tests, docs, CI workflows, commit messages or pull request descriptions.
logic_claims:
  - CLAIM-D5F725F4E1827654
semantic_clauses:
  - Project must not name specific downstream or consumer projects in code, tests, docs, CI workflows, commit messages or pull request descriptions.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 1ffd4c002a9f2a5800263b7d05fd4784e7703b4d8c6e5b280542054fe3600452
semantic_inventory:
  - claim_key: CLAIM-D5F725F4E1827654
    claim_text: Project must not name specific downstream or consumer projects in code, tests, docs, CI workflows, commit messages or pull request descriptions
    role: normative
    status: modeled
    span:
      start: 0
      end: 143
rationale: Piotr wants Mutalog to be a standalone general-purpose library.
origin:
  kind: import
  ref: agents:AGENTS.md#L3
  recorded_at: '2026-10-29T16:05:25.940Z'
firmness: firm
required_evidence: asserted
proof_exempt: true
proof_exempt_reason: "process rule about repository content and pull request text, enforced in review; there is no behaviour to run"
id: REQ-AUTO-7111A81FAC739FCB
type: req
---
Project must not name specific downstream or consumer projects in code, tests, docs, CI workflows, commit messages or pull request descriptions.

## Context

Piotr wants Mutalog to be a standalone general-purpose library.

## Source

> Mutalog is a standalone, general-purpose mutation testing library for

Source: Agent guidelines - AGENTS.md#L3
