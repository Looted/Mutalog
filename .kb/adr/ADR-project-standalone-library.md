---
title: Keep Mutalog independent of downstream projects
status: accepted
tags:
  - decision
  - project
origin:
  kind: import
  ref: agents:AGENTS.md#L3
  recorded_at: '2026-10-29T16:05:53.214Z'
id: ADR-project-standalone-library
type: adr
---
## Context

Mutalog is meant to be a standalone, general-purpose library. Piotr asked on 2026-10-29 that no downstream or consumer project be named in its code, tests, docs, CI, commits or pull requests.

## Decision

Repository content uses the bundled fixture project in test/project/ or generic examples. Validation against real-world codebases happens outside this repository, and only generic findings are reported here. Development tools used on the repository itself, such as this knowledge base and its report badge, are allowed.

## Consequences

The library has no knowledge of who uses it, and the rule is recorded in AGENTS.md for every contributor.
