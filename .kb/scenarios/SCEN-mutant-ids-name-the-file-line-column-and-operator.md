---
title: Mutant ids name the file, line, column and operator
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:17.830Z'
id: SCEN-mutant-ids-name-the-file-line-column-and-operator
type: scenario
---
Given the example project, when the user lists the mutants as JSON, then each id splits into the file path, the start line and column, the operator and a number, and all 55 ids are unique.

## Context

Checked end to end by `e2e:mutant_ids_name_file_line_column_operator`, which runs Mutalog as a separate process.
