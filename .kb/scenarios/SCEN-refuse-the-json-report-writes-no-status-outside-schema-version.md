---
title: The JSON report writes no status outside schema version 2
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:33:14.179Z'
id: SCEN-refuse-the-json-report-writes-no-status-outside-schema-version
type: scenario
---
Given the example project, when the user runs mutalog run with the json reporter, then mutation.json declares schemaVersion 2 and no mutant carries a status, field or location shape the schema does not define.

## Context

Failure side of REQ-AUTO-20DC4E062C4C1FC7. Checked end to end by `e2e:json_report_follows_schema_v2`.
