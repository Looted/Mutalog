---
title: 'Operators must include cut, which mutates: Removes a cut; inserts one after the first goal of a non-last clause that has none.'
status: open
text_ref: readme:README.md#L120
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:readme-readme-md-l120
  - lane:strict
semantic_text: 'Operators must include cut, which mutates: Removes a cut; inserts one after the first goal of a non-last clause that has none.'
logic_claims:
  - CLAIM-1B3B492641375B1A
semantic_clauses:
  - 'Operators must include cut, which mutates: Removes a cut; inserts one after the first goal of a non-last clause that has none.'
semantic_inventory_version: kibi.semantic-inventory.v1
semantic_source_field: semantic_text
semantic_source_hash: 34f67525f7f38f9c2a3b4b0f91adab2199a20253de24329a5938d12357c1554c
semantic_inventory:
  - claim_key: CLAIM-1B3B492641375B1A
    claim_text: 'Operators must include cut, which mutates: Removes a cut; inserts one after the first goal of a non-last clause that has none'
    role: normative
    status: modeled
    span:
      start: 0
      end: 125
origin:
  kind: import
  ref: readme:README.md#L120
  recorded_at: '2026-10-29T16:05:27.940Z'
firmness: firm
required_evidence: asserted
id: REQ-AUTO-1BE4DE98E4A99F3C
type: req
---
Operators must include cut, which mutates: Removes a cut; inserts one after the first goal of a non-last clause that has none.

## Source

> | `cut` | Removes a cut; inserts one after the first goal of a non-last clause that has none | `p :- q, !, r.` to `p :- q, true, r.` |

Source: Mutalog README - README.md#L120
