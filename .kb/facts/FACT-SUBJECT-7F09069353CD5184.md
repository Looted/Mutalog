---
title: Controller Hard Limit
status: active
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
  - fact:subject
  - vocabulary:new-subject
fact_kind: subject
subject_key: controller.hard_limit
canonical_key: controller.hard_limit
claim_key: CLAIM-9689B01275D74ACA
claim_text: Controller must enforce a hard limit 10 seconds after the worker time limit and replace a worker that misses it.
origin:
  kind: agent
  recorded_at: '2026-11-02T14:26:10.664Z'
id: FACT-SUBJECT-7F09069353CD5184
type: fact
---
The controller-side hard limit, a fixed margin after the worker time limit (run.mutant_time_limit), after which the controller kills a worker that has not answered and starts a fresh one. It exists because code under test can catch the time limit exception and loop on.