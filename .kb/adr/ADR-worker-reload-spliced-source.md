---
title: Apply mutants by reloading spliced source text
status: accepted
tags:
  - decision
  - runner
  - worker
origin:
  kind: import
  ref: plan:architecture/applying-a-mutant-inside-a-worker
  recorded_at: '2026-10-29T16:05:46.945Z'
id: ADR-worker-reload-spliced-source
type: adr
---
## Context

The design plan proposed swapping a single clause in memory: declare mutable predicates dynamic at load time, retract the original clause and its tail, and assert the mutant in its place. While building M2 this proved fragile, because it changes how predicates are compiled and breaks on static predicates and load-time side effects.

## Decision

A worker applies a mutant by reloading the whole file from its source text with the replacement spliced in, through load_files/2 with a stream. The original text is reloaded to restore it. Source files on disk are never written.

## Consequences

Mutated code is compiled exactly like the original, so the mutant behaves as it would if the developer had made the change. mutalog list --check re-reads every spliced mutant to prove the splice parses to the intended clause.
