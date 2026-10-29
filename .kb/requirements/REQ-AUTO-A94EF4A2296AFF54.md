---
title: Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it.
status: open
text_ref: readme:README.md#L135
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:readme-readme-md-l135
  - lane:strict
semantic_text: Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it.
logic_claims:
  - CLAIM-9689B01275D74ACA
semantic_clauses:
  - Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 5af81e2e190538c955e26aaa74648c07f040f6b59ad6fcf9e32146884e5c8c84
semantic_inventory:
  - claim_key: CLAIM-9689B01275D74ACA
    claim_text: Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it
    role: normative
    status: modeled
    span:
      start: 0
      end: 111
rationale: Code under test can catch the time limit exception and loop on.
origin:
  kind: import
  ref: readme:README.md#L135
  recorded_at: '2026-10-29T16:05:34.136Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-A94EF4A2296AFF54
type: req
---
Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it.

## Context

Code under test can catch the time limit exception and loop on.

## Source

> so the controller also enforces a hard limit 10 seconds later.

Source: Mutalog README - README.md#L135
