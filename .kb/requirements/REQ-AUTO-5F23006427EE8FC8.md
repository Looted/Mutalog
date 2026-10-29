---
title: Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms.
status: open
text_ref: readme:README.md#L135
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:readme-readme-md-l135
  - lane:strict
semantic_text: Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms.
logic_claims:
  - CLAIM-3ADF1A384031DF74
semantic_clauses:
  - Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms.
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 94a5234ffcc563255b4986ed04550be3c2425c9ad0442a77fb301e81e275adde
semantic_inventory:
  - claim_key: CLAIM-3ADF1A384031DF74
    claim_text: Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms
    role: normative
    status: modeled
    span:
      start: 0
      end: 102
origin:
  kind: import
  ref: readme:README.md#L135
  recorded_at: '2026-10-29T16:05:33.669Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-5F23006427EE8FC8
type: req
---
Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms.

## Source

> Each mutant gets a limit of `timeout_factor` times its covering tests' dry-run time, plus `timeout_ms`.

Source: Mutalog README - README.md#L135
