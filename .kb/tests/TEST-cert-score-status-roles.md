---
title: The score counts killed and timeout over killed, timeout, survived and no coverage
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-run-reports-statuses-and-score
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/run.pl
    functor: score_status/1
  proves:
    - CLAIM-749433B555707ACE
origin:
  kind: agent
  recorded_at: '2026-11-02T12:15:36.021Z'
id: TEST-cert-score-status-roles
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-5e6f2d3f250f8958613e83ac
    test_id: TEST-cert-score-status-roles
    scope: integration
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 1b165743803211ef8e3c799887a3b0280b34dcfb8d771bea5eed07cc611f4829
    binding_hash: e557f5e6c6e317fa92823eef0824a7abdd9b294fea02c3a18ea7cc178f8ae52c
    fingerprint: 232493b6b6b7b72a09e9785634bd2db07747ce0896746a649711c36ab80f6a0c
    fingerprint_components:
      contract: 1b165743803211ef8e3c799887a3b0280b34dcfb8d771bea5eed07cc611f4829
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
      - symbol_id: SYM-test-e2e-run-reports-statuses-and-score
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
      test_id: TEST-cert-score-status-roles
      source:
        reader: prolog
        file: prolog/mutalog/run.pl
        functor: score_status/1
      model:
        members:
          - killed-detected
          - no_coverage-undetected
          - survived-undetected
          - timeout-detected
        sequence:
          - killed-detected
          - timeout-detected
          - survived-undetected
          - no_coverage-undetected
    certificate_digest: b73520e687e6019464d8dd35df36bf03c1ecb55fde8701814b3cc14e9cf2d759
    claim_bindings:
      - claim_key: CLAIM-749433B555707ACE
        requirement_id: REQ-AUTO-AEACADEB6A56DDD2
        fact_id: FACT-PROP-1481CEFCF776F52A
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - killed-detected
            - no_coverage-undetected
            - survived-undetected
            - timeout-detected
          operator: eq
---
Source proof for REQ-AUTO-AEACADEB6A56DDD2. Kibi reads the `score_status/1` facts of `prolog/mutalog/run.pl`, which `mutation_score/3` sums: killed and timeout are detected, survived and no_coverage are not, and no other status is scored.

## Context

The proof run executes the end-to-end test `e2e:run_reports_statuses_and_score`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
