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
    receipt_id: PR-06240142f5e2c312eb80bf75
    test_id: TEST-cert-default-operators-include-negate
    scope: integration
    outcome: passed
    code_snapshot: 92e3954df4f617ded2727621938b06fd4e05ade1fa7b70daf347fa96818d6d78
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T11:39:41.926Z'
    finished_at: '2026-11-02T11:40:29.375Z'
    artifact_digest: 7d01fd058c5eddf0d483e1e7fec068a609ce5e15ae1c3d99860885d6a7727ec2
    contract_hash: 2c58520b02b962737d6aa7f32b92023e8a06361060b4973194dd526732916b83
    binding_hash: 2ed87d6c08188a325e58915e08aa8c25c7a59d508d3e3e1f6b0981a4eeb7a0d3
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
