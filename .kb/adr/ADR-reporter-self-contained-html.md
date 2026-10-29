---
title: Ship a self-contained HTML report
status: accepted
tags:
  - decision
  - reporter
origin:
  kind: import
  ref: plan:configuration-cli-and-reports/reports
  recorded_at: '2026-10-29T16:05:49.469Z'
id: ADR-reporter-self-contained-html
type: adr
---
## Context

The design plan proposed an HTML page that embeds the JSON and loads a report web component from a CDN. That page breaks offline, in sandboxed CI viewers and behind proxies.

## Decision

mutation.html is one self-contained page with its script and styles inlined and no network access. mutation.json follows the open mutation-testing-report-schema, version 2, so other tools that read the format can still use it.

## Consequences

The report opens anywhere, including as a CI artifact. The JSON schema conformance is checked against the published schema.
