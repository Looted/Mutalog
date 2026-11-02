---
title: The default operators include goal_fail
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-goal-fail
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-167FB02AB48BA73D
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:28.044Z'
id: TEST-cert-default-operators-include-goal-fail
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-52e716137013ab036175a46c
    test_id: TEST-cert-default-operators-include-goal-fail
    scope: integration
    outcome: passed
    code_snapshot: 92e3954df4f617ded2727621938b06fd4e05ade1fa7b70daf347fa96818d6d78
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T11:39:41.926Z'
    finished_at: '2026-11-02T11:40:29.375Z'
    artifact_digest: 7d01fd058c5eddf0d483e1e7fec068a609ce5e15ae1c3d99860885d6a7727ec2
    contract_hash: 95df1c933dd02e96a974bdb13c7cb24b49a828602e676b78d632e57e1d69ba54
    binding_hash: 2e2248394b6ef04bdc39f378cb81cfbad0fbcbc0329669aa2890734c37983873
    fingerprint: aa563dfb82ae4c18b2fb6b52595fe7553de5d403ed25ebfce913594cb6c5d543
    fingerprint_components:
      contract: 95df1c933dd02e96a974bdb13c7cb24b49a828602e676b78d632e57e1d69ba54
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
      - symbol_id: SYM-test-e2e-operator-goal-fail
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
      test_id: TEST-cert-default-operators-include-goal-fail
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
    certificate_digest: 29c78a86a641ecae178c39ca87ad48e806804184ce31198473c3f11654dce7a5
    claim_bindings:
      - claim_key: CLAIM-167FB02AB48BA73D
        requirement_id: REQ-AUTO-653372986C2F6926
        fact_id: FACT-PROP-0877E589282770AD
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - goal_fail
          operator: includes
---
Source proof for REQ-AUTO-653372986C2F6926. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `goal_fail`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_goal_fail`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
