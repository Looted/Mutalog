---
title: The default operators include negate
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-negate
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-80D88D3ED898DA32
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:17.196Z'
id: TEST-cert-default-operators-include-negate
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-93364e8555f16fa84b4ec82e
    test_id: TEST-cert-default-operators-include-negate
    scope: integration
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 2c58520b02b962737d6aa7f32b92023e8a06361060b4973194dd526732916b83
    binding_hash: 2440d6d839b05d7d1982eff8c2219421565e12f5bfa63b2e2c2f4c06af48b107
    fingerprint: dfe62e9fdddddd0f9319c9c53bcdb9181d8b3209b8e7111cb9ea8a1f2d513314
    fingerprint_components:
      contract: 2c58520b02b962737d6aa7f32b92023e8a06361060b4973194dd526732916b83
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
      - symbol_id: SYM-test-e2e-operator-negate
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
      test_id: TEST-cert-default-operators-include-negate
      source:
        reader: prolog
        file: prolog/mutalog/config.pl
        functor: default_operators/1
      model:
        members:
          - arith
          - clause_drop
          - compare
          - cut
          - cut_insert
          - goal_fail
          - goal_true
          - literal
          - negate
          - unify
        sequence:
          - arith
          - compare
          - unify
          - negate
          - cut
          - cut_insert
          - goal_true
          - goal_fail
          - clause_drop
          - literal
    certificate_digest: 62c4402a1496d95d1198da26794b4b4976e38cb6666e4b4f4e3740187fbb3894
    claim_bindings:
      - claim_key: CLAIM-80D88D3ED898DA32
        requirement_id: REQ-AUTO-0675D067D8B21673
        fact_id: FACT-PROP-350A3DEF3BDFEB35
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - negate
          operator: includes
---
Source proof for REQ-AUTO-0675D067D8B21673. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `negate`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_negate`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
