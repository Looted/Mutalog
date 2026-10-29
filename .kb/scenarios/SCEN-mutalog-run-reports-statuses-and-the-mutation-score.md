---
title: mutalog run reports statuses and the mutation score
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:35.634Z'
id: SCEN-mutalog-run-reports-statuses-and-the-mutation-score
type: scenario
---
Given the example project, when the user runs mutalog run, then the report holds 35 killed, 12 survived, 2 timed out and 6 uncovered mutants and the score is 67.3%.

## Context

Checked end to end by `e2e:run_reports_statuses_and_score`, which runs Mutalog as a separate process.
