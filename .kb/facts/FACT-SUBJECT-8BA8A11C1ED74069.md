---
title: Config Default Operators
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
subject_key: config.default_operators
canonical_key: config.default_operators
claim_key: CLAIM-80D88D3ED898DA32
claim_text: 'Operators must include negate, which mutates: Removes a `\+`; negates the condition of an if-then-else.'
origin:
  kind: agent
  recorded_at: '2026-11-02T11:27:04.354Z'
id: FACT-SUBJECT-8BA8A11C1ED74069
type: fact
---
The mutation operators a run enables when neither the config `operators` key nor `--operators` chooses them: arith, compare, unify, negate, cut, cut_insert, goal_true, goal_fail, clause_drop and literal (`default_operators/1` in `prolog/mutalog/config.pl`). It is not the hooks that define operators (operators.hooks).