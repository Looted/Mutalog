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
    receipt_id: PR-8308309c0e59626b4e23ec81
    test_id: TEST-cert-score-status-roles
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: 1b165743803211ef8e3c799887a3b0280b34dcfb8d771bea5eed07cc611f4829
    binding_hash: a65eb45ae38e5eac75751aec0f8e89e1fe2a66ee80fe5ea7cf3014bd8f107ddc
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
