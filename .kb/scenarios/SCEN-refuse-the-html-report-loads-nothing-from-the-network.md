---
title: The HTML report loads nothing from the network
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:20.533Z'
id: SCEN-refuse-the-html-report-loads-nothing-from-the-network
type: scenario
---
Given the example project, when the user runs mutalog run with the html reporter, then mutation.html references no external script, style or data.

## Context

Failure side of REQ-AUTO-CB32BF7DBFE62DAA. Checked end to end by `e2e:html_report_is_self_contained`.
