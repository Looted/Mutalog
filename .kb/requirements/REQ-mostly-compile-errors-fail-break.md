---
title: A run in which more than half of the mutants do not load must exit with 1 when the break threshold is above 0.
status: open
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
semantic_text: A run in which more than half of the mutants do not load must exit with 1 when the break threshold is above 0.
logic_claims:
  - CLAIM-569809DA0708FEE7
semantic_clauses:
  - A run in which more than half of the mutants do not load must exit with 1 when the break threshold is above 0.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 7230feadac35c2b8a360cfb5c5e54ef927f072304ac2f40edc7c713068857786
semantic_inventory:
  - claim_key: CLAIM-569809DA0708FEE7
    claim_text: A run in which more than half of the mutants do not load must exit with 1 when the break threshold is above 0
    role: normative
    status: modeled
    span:
      start: 0
      end: 109
required_evidence: asserted
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:21.288Z'
id: REQ-mostly-compile-errors-fail-break
type: req
---
A run in which more than half of the mutants do not load must exit with 1 when the break threshold is above 0.

## Context

A run with 2,683 compile errors out of 3,099 mutants reported 100% and passed break(100), hiding a broken run (issue #24). Generated mutants always parse, so many compile errors mean the run itself is broken.

## Source

> Issue #24: A run where most mutants are compile errors still passes the break threshold