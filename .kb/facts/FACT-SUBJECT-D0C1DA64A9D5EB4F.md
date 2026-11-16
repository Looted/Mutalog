---
title: Packaging Keep Node Dependency
status: active
text_ref: plan:open-decisions/language-of-the-tool
tags:
  - strict-modeling
  - confidence:0.82
  - confidence-band:medium
  - provenance:plan-open-decisions-language-of-the-tool
  - lane:strict
  - fact:subject
fact_kind: subject
subject_key: packaging.keep_node_dependency
canonical_key: packaging.keep_node_dependency
claim_key: CLAIM-BDE1D5CCE8BF84EC
claim_text: Packaging must keep Mutalog pure SWI-Prolog with no Node dependency.
origin:
  kind: agent
  recorded_at: '2026-10-29T16:05:41.167Z'
id: FACT-SUBJECT-D0C1DA64A9D5EB4F
type: fact
---
Whether the pack needs Node.js. The pack is pure SWI-Prolog; the repository's `package.json` holds development and release tooling only and is not shipped in the pack. See pack.manifest.