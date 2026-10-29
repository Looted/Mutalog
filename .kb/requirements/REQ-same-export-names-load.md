---
title: Mutants of two mutated modules that export the same name must load.
status: open
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
semantic_text: Mutants of two mutated modules that export the same name must load.
logic_claims:
  - CLAIM-85AB7ED762423402
semantic_clauses:
  - Mutants of two mutated modules that export the same name must load.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: fa763774f27c03cd6c0606235394b88b75a91ed001d9f462a2b4c98c06a6675f
semantic_inventory:
  - claim_key: CLAIM-85AB7ED762423402
    claim_text: Mutants of two mutated modules that export the same name must load
    role: normative
    status: modeled
    span:
      start: 0
      end: 66
required_evidence: asserted
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:15.092Z'
id: REQ-same-export-names-load
type: req
---
Mutants of two mutated modules that export the same name must load.

## Context

Until 0.3.2 the worker imported every module it reloaded into itself, so the second of two modules exporting the same name hit a permission error and all its mutants were reported as compile errors. Found while fixing issue #23.

## Source

> PR #25: Two mutated modules that export the same name no longer clash, because the reload imports nothing into the worker module.