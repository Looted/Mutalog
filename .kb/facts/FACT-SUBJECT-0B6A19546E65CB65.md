---
title: Config Keys
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
subject_key: config.keys
canonical_key: config.keys
claim_key: CLAIM-7E601561E9998F9C
claim_text: Config must be read from an optional mutalog.config.pl in the project root where every key is optional.
origin:
  kind: agent
  recorded_at: '2026-11-02T12:11:21.222Z'
id: FACT-SUBJECT-0B6A19546E65CB65
type: fact
---
The keys a project may put in its optional `mutalog.config.pl` (mutate, ignore, tests, load, operators, ignore_mutants, timeout_ms, timeout_factor, stack_limit, concurrency, retries, worker_reuse, thresholds, reporters, report_dir, root), read by `prolog/mutalog/config.pl`. It does not include command-line options, which override these keys but are parsed in `prolog/mutalog.pl`.