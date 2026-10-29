---
title: The JSON report follows schema version 2
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:47.928Z'
id: SCEN-the-json-report-follows-schema-version-2
type: scenario
---
Given the example project, when the user runs mutalog run with the json reporter, then mutation.json has schemaVersion 2, thresholds, the file source and language, and each mutant has an id, mutatorName, location and a schema status.

## Context

Checked end to end by `e2e:json_report_follows_schema_v2`, which runs Mutalog as a separate process.
