---
title: Two modules exporting the same name cause no compile error
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:35:43.543Z'
id: SCEN-refuse-two-modules-exporting-the-same-name-cause-no-compile-er
type: scenario
---
Given modules a and c that both export f/2, both mutated, when the user runs mutalog run, then no mutant fails to load: there are no compile errors and every mutant is Killed.

## Context

Failure side of REQ-same-export-names-load. Checked end to end by `e2e:mutates_modules_that_export_the_same_name`.
