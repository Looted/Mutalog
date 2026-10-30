---
title: The version step syncs pack.pl and the changelog
status: active
origin:
  kind: agent
  recorded_at: '2026-10-30T13:58:22.023Z'
id: SCEN-the-version-step-syncs-pack-and-changelog
type: scenario
---
Given a checkout where package.json has a new version and CHANGELOG.md has the section `changeset version` writes under its title, when scripts/sync-version.mjs runs, pack.pl carries the new version, the section is dated, has no "### ... Changes" headings and sits below the introduction above the previous version, release-check.sh passes and release-notes.sh prints its bullets.

## Context

Checked end to end by `e2e:version_step_syncs_pack_and_changelog`, which runs the scripts as separate processes.