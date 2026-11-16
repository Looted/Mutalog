---
title: Version Step
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
subject_key: version_step
canonical_key: version_step
claim_key: CLAIM-17DB9B8D395EACE8
claim_text: The version step must copy the version in package.json into pack.pl and write a dated CHANGELOG.md section for it below the introduction.
origin:
  kind: agent
  recorded_at: '2026-10-30T13:58:07.900Z'
id: FACT-SUBJECT-246AD8C9AF5A1C46
type: fact
---
The release version step `npm run version-packages`: `changeset version` followed by `scripts/sync-version.mjs`, which copies the version from `package.json` into `pack.pl` and dates the new `CHANGELOG.md` section. It is not the Release workflow (release.workflow), which publishes a version after it is merged.