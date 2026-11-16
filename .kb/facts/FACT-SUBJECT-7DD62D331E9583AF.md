---
title: Run Mutant Time Limit
status: active
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
  - fact:subject
fact_kind: subject
subject_key: run.mutant_time_limit
canonical_key: run.mutant_time_limit
claim_key: CLAIM-3ADF1A384031DF74
claim_text: Runner must limit each mutant to timeout_factor times its covering tests' dry-run time plus timeout_ms.
origin:
  kind: agent
  recorded_at: '2026-11-02T12:11:29.583Z'
id: FACT-SUBJECT-7DD62D331E9583AF
type: fact
---
The per-mutant time limit: `timeout_factor` times the dry-run time of the tests that cover the mutant, plus `timeout_ms`, enforced in the worker with `call_with_time_limit/2`. Distinct from controller.hard_limit, the controller-side limit enforced after it.