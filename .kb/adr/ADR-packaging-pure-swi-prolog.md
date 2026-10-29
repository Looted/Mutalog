---
title: Write Mutalog in pure SWI-Prolog
status: accepted
tags:
  - decision
  - packaging
origin:
  kind: import
  ref: plan:open-decisions/language-of-the-tool
  recorded_at: '2026-10-29T16:05:44.597Z'
id: ADR-packaging-pure-swi-prolog
type: adr
---
## Context

The design plan weighed a pure SWI-Prolog pack against a plugin for an existing JavaScript mutation testing tool that shells out to swipl. A plugin would reuse existing reporters for free, but would tie Mutalog to the Node ecosystem and to another tool's plugin API.

## Decision

Mutalog is a pure SWI-Prolog pack with no dependencies outside the SWI-Prolog distribution, installable with pack_install. Report compatibility comes from writing JSON in the open mutation-testing-report-schema instead.

## Consequences

Prolog users install it like any other pack. Development tooling in this repository (package.json, used only for the knowledge base and its report) is not part of the pack and is never a runtime dependency.
