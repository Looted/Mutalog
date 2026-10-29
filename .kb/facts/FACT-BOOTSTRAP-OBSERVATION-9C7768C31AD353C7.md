---
title: The design plan applied mutants by asserting the mutated clause in place of the original; the built runner instead reloads the file from spliced source text.
status: active
fact_kind: observation
text_ref: plan:architecture/applying-a-mutant-inside-a-worker
tags:
  - bootstrap
  - knowledge-source:plan
  - claim:observation
origin:
  kind: agent
  recorded_at: '2026-10-29T16:05:40.962Z'
id: FACT-BOOTSTRAP-OBSERVATION-9C7768C31AD353C7
type: fact
---
The design plan applied mutants by asserting the mutated clause in place of the original; the built runner instead reloads the file from spliced source text.

## Source

> To apply a mutant the worker reads the mutated clause text with the same reader, asserts it in place of the original, runs the tests, and reasserts the original.

Source: Mutalog design plan: first draft - architecture/applying-a-mutant-inside-a-worker
