---
title: The HTML report needs no network
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:46.887Z'
id: SCEN-the-html-report-needs-no-network
type: scenario
---
Given the example project, when the user runs mutalog run with the html reporter, then mutation.html shows the mutants and loads no external script, style or data.

## Context

Checked end to end by `e2e:html_report_is_self_contained`, which runs Mutalog as a separate process.
