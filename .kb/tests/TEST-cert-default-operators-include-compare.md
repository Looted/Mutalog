---
title: The default operators include compare
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-compare
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-A324A6E0A2D3DB1A
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:34.777Z'
id: TEST-cert-default-operators-include-compare
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-d6d6c48c06fdd1788b62a716
    test_id: TEST-cert-default-operators-include-compare
    scope: integration
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: 7b3617c515cc5cc363560e8395e55f0eff3c2c61995e221e347e7f27a653641a
    binding_hash: a4c681d399d80fb6960fb96991f562f2d6064110ce3a1915eb0d9e1dbaacdd82
    fingerprint: 4c76f5cb99f268f723527acf43006b957885a191471a3f026dedcfd4394ba25d
    fingerprint_components:
      contract: 7b3617c515cc5cc363560e8395e55f0eff3c2c61995e221e347e7f27a653641a
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
      - symbol_id: SYM-test-e2e-operator-compare
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
      test_id: TEST-cert-default-operators-include-compare
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
    certificate_digest: 5e386bf9eb987df7c60eca4e6c9a778b101b0d1eaa6471ec4093ff3cc555fd99
    claim_bindings:
      - claim_key: CLAIM-A324A6E0A2D3DB1A
        requirement_id: REQ-AUTO-BBEC6285F92001DC
        fact_id: FACT-PROP-7250C51B993F6A67
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - compare
          operator: includes
---
Source proof for REQ-AUTO-BBEC6285F92001DC. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `compare`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_compare`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
