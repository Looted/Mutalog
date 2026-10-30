---
title: A push to master with an untagged version releases
status: active
origin:
  kind: agent
  recorded_at: '2026-10-30T23:26:16.748Z'
id: SCEN-release-on-push-to-master-with-an-untagged-version
type: scenario
---
Given a checkout whose master is pushed to origin and whose pack.pl version has no tag, when the Release workflow's decision runs for a push to master it outputs release=true. For a push to another branch it fails without output, and once the tag is pushed it outputs release=false.

## Context

Checked end to end by `e2e:release_on_push_to_master_with_an_untagged_version`, which runs `scripts/release-decide.sh` as a separate process against a local origin, and by a source proof that the Release workflow runs on pushes to master.