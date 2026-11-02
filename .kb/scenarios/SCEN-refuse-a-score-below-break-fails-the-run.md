---
title: A score below break fails the run
status: active
expects: rejection
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:13.759Z'
id: SCEN-refuse-a-score-below-break-fails-the-run
type: scenario
---
Given the example project scoring 67.3%, when the user runs mutalog run with break 90, then the run fails with exit status 1.

## Context

Failure side of REQ-AUTO-B6447158DD93403B. Checked end to end by `e2e:break_threshold_sets_the_exit_code`.
