---
title: npm run version-packages runs sync-version.mjs
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-version-step-runs-sync-version
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: json
    file: package.json
    path: scripts.version-packages
  proves:
    - CLAIM-17DB9B8D395EACE8
origin:
  kind: agent
  recorded_at: '2026-10-30T23:26:20.278Z'
id: TEST-version-step-runs-sync-version
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-6e205f9c27b94d6d577cd679
    test_id: TEST-version-step-runs-sync-version
    scope: integration
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 86bb25c01c98b0d985bb923d2a192cfdcc8eb7fdcba6559df80c7d56f61bbe1b
    binding_hash: a768eb5e06a5cf06ae2bfe00abf4556d2888ae87cc7722d67de37b26b4f79af8
    fingerprint: 4abc94ee4a258b582c5e6d8827758df8f56f91a4eb96d18a91d71043c72e45cb
    fingerprint_components:
      contract: 86bb25c01c98b0d985bb923d2a192cfdcc8eb7fdcba6559df80c7d56f61bbe1b
      integration: c737391e036529661d1133ede485cc0c7e0cd44f13a68e4ca3ca4ce96e583b98
      command: c9ec4783a29134c6c0d1c8e48e18a94e22343779b220e65da267bcaebe14f40b
      bindings: 4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945
      producer: 3f1ef45ea6f7a150dff44ba43ea098e729d8dcd4e35f67bb455191a7f38609be
    integration_id: unit
    producer:
      name: kibi-command-producer
    command_argv:
      - npx
      - kibi
      - proof
      - run-steps
    run_outcome: passed
    proof_results:
      - symbol_id: SYM-test-version-step-runs-sync-version
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: source
    evidence_level: proved
    certificate:
      version: kibi.code-certificate.v1
      kind: source
      test_id: TEST-version-step-runs-sync-version
      source:
        reader: json
        file: package.json
        path: scripts.version-packages
      model:
        members:
          - changeset version && node scripts/sync-version.mjs
    certificate_digest: ea3585d0c8d7c89bb32ca4b79359f8521570ec5337a8df0301d15338f9abb22f
    claim_bindings:
      - claim_key: CLAIM-17DB9B8D395EACE8
        requirement_id: REQ-release-version-step-syncs-pack
        fact_id: FACT-PROP-375CB78425F14543
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - changeset version && node scripts/sync-version.mjs
          operator: includes
---
Source proof that the version step, `npm run version-packages`, runs `scripts/sync-version.mjs` after `changeset version`.

## Context

Kibi reads `scripts.version-packages` in `package.json` and checks that it is `changeset version && node scripts/sync-version.mjs`. The end-to-end test `TEST-e2e-version-step-syncs-pack-and-changelog` shows that the script copies the version into pack.pl and writes the dated CHANGELOG.md section.