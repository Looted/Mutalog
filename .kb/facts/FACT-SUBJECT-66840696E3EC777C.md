---
title: Runner Dry Run
status: active
text_ref: readme:README.md#L133
tags:
  - strict-modeling
  - confidence:0.90
  - confidence-band:high
  - provenance:readme-readme-md-l133
  - lane:strict
  - fact:subject
fact_kind: subject
subject_key: runner.dry_run
canonical_key: runner.dry_run
claim_key: CLAIM-88EB1C6599EE5F14
claim_text: Dry run must stop the run when a test fails, because mutants can only be judged against a green suite.
origin:
  kind: agent
  recorded_at: '2026-10-29T16:05:31.453Z'
id: FACT-SUBJECT-66840696E3EC777C
type: fact
---
The dry run that runs the whole test suite once in a child `swipl` before any mutant, also available as `mutalog dry-run`. A failing test stops the run. coverage.dry_test is the per-test measurement it takes.