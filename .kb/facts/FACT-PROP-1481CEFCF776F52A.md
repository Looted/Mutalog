---
title: Status Roles = killed-detected, no_coverage-undetected, survived-undetected, timeout-detected
status: active
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
  - fact:property_value
fact_kind: property_value
subject_key: run.mutation_score
property_key: status_roles
canonical_key: mcp-kibi-model-requirement:run.mutation_score:status_roles:eq:killed-detected_no_coverage-undetected_survived-undetected_timeout-detected
operator: eq
value_type: set
value_set:
  - killed-detected
  - no_coverage-undetected
  - survived-undetected
  - timeout-detected
claim_key: CLAIM-749433B555707ACE
claim_text: Reporter must compute the mutation score as killed plus timeout over killed, timeout, survived and no coverage.
origin:
  kind: agent
  recorded_at: '2026-11-02T12:12:20.595Z'
id: FACT-PROP-1481CEFCF776F52A
type: fact
---
