---
title: The config file is optional and read when present
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:32.604Z'
id: SCEN-the-config-file-is-optional-and-read-when-present
type: scenario
---
Given the example project without mutalog.config.pl, when the user lists with --mutate, then all 55 mutants are found; when a config naming only arith is added, then only the 2 arith mutants are listed.

## Context

Checked end to end by `e2e:config_file_is_optional_and_read`, which runs Mutalog as a separate process.
