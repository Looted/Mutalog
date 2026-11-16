---
title: Ci Test Job
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
subject_key: ci.test_job
canonical_key: ci.test_job
claim_key: CLAIM-59378A68EEBBC818
claim_text: CI must fail when the version in pack.pl has no matching section in CHANGELOG.md.
origin:
  kind: agent
  recorded_at: '2026-10-29T18:01:54.063Z'
id: FACT-SUBJECT-44C4E9CDF1E7B5AA
type: fact
---
The test job of the CI workflow `.github/workflows/ci.yml` that runs on pull requests and pushes, including the release consistency check `scripts/release-check.sh`. It is not the Release workflow (release.workflow), which publishes.