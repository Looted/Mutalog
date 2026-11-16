---
title: Client Worker
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
subject_key: client.worker
canonical_key: client.worker
claim_key: CLAIM-31AEF4005052471E
claim_text: Runner must run mutants in child processes, not threads, loading the project once per worker.
origin:
  kind: agent
  recorded_at: '2026-11-02T11:27:43.960Z'
id: FACT-SUBJECT-EB7AA39EFFE605B0
type: fact
---
The controller-side handling of worker processes in `prolog/mutalog/client.pl`: starting a child `swipl` per worker, talking to it over pipes, and killing and replacing it. Mutants run in processes, not threads. Distinct from runner.worker, the child process itself.