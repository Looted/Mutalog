---
title: A clause that a mutant drops must not answer calls once the mutant is loaded.
status: open
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
semantic_text: A clause that a mutant drops must not answer calls once the mutant is loaded.
logic_claims:
  - CLAIM-EDA5C7082929B5CE
semantic_clauses:
  - A clause that a mutant drops must not answer calls once the mutant is loaded.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 6c98de4f4b9001fa75c3898571bd3d11d1b627fbe393e49d5f4e1cbe6c6d8bed
semantic_inventory:
  - claim_key: CLAIM-EDA5C7082929B5CE
    claim_text: A clause that a mutant drops must not answer calls once the mutant is loaded
    role: normative
    status: modeled
    span:
      start: 0
      end: 76
required_evidence: asserted
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:27.320Z'
id: REQ-dropped-clauses-stop-answering
type: req
---
A clause that a mutant drops must not answer calls once the mutant is loaded.

## Context

SWI-Prolog before 10.1.19 leaves the clauses a reload drops from a static predicate in its JIT indexes, so a dropped clause could still answer and a mutant survived depending on which mutants its worker ran before (issue #21). The worker unloads the file before loading each mutant to avoid it.

## Source

> Issue #21: On SWI-Prolog 10, a mutant can run against a stale definition left by an earlier mutant of the same file, so it survives