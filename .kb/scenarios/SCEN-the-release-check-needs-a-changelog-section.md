---
title: The release check needs a changelog section
status: active
origin:
  kind: agent
  recorded_at: '2026-10-29T17:52:51.881Z'
id: SCEN-the-release-check-needs-a-changelog-section
type: scenario
---
Given a checkout, when scripts/release-check.sh runs, then it prints the pack.pl version; after bumping pack.pl to a version with no CHANGELOG.md section, it fails and names the missing section.

## Context

Checked end to end by `e2e:release_check_requires_a_changelog_section`, which runs Mutalog as a separate process.
