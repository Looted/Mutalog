---
title: Every mutant of a module that another loaded module imports must load.
status: open
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
semantic_text: Every mutant of a module that another loaded module imports must load.
logic_claims:
  - CLAIM-5E35237EA8AC7184
semantic_clauses:
  - Every mutant of a module that another loaded module imports must load.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 1dbb3540cb043b6168fcc318627a72ca360a31624c15471715f0f85922f86f0e
semantic_inventory:
  - claim_key: CLAIM-5E35237EA8AC7184
    claim_text: Every mutant of a module that another loaded module imports must load
    role: normative
    status: modeled
    span:
      start: 0
      end: 69
required_evidence: asserted
origin:
  kind: agent
  recorded_at: '2026-10-29T19:05:58.210Z'
id: REQ-mutants-of-imported-modules-load
type: req
---
Every mutant of a module that another loaded module imports must load.

## Context

Mutant generation only produces text that parses, so a mutant that fails to load points at the worker, not the mutant. Version 0.3.1 reloaded files in a way SWI-Prolog refused for any module another module had imported, and every such mutant became a compile error (issue #23). The test suite missed it because its only project had one module, imported by a test file. Piotr asked for coverage that would have caught it.

## Source

> Issue #23: 0.3.1: every mutant of a module that another loaded module imports is a compile_error