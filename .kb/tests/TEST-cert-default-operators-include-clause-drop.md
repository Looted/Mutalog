---
title: The default operators include clause_drop
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-clause-drop
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-50111E648A1C7A1B
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:19.360Z'
id: TEST-cert-default-operators-include-clause-drop
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-921e605c34b25dcb75277e8a
    test_id: TEST-cert-default-operators-include-clause-drop
    scope: integration
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: 4e02411ff451f8119ae36178bcef26cd2f394751102a9ccfc3eaa71da3a03473
    binding_hash: 7ed858724cd5a7d53b12baffb05d65059533bbc027bdcd6a843efe2fd4e3e2b3
    fingerprint: 91c20aeeb6d2125f9d5addde15c3568711f686dab88c65c337b73f2287eb3cbc
    fingerprint_components:
      contract: 4e02411ff451f8119ae36178bcef26cd2f394751102a9ccfc3eaa71da3a03473
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
      - symbol_id: SYM-test-e2e-operator-clause-drop
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
      test_id: TEST-cert-default-operators-include-clause-drop
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
    certificate_digest: 3cc116d36fbfa00cb1819ee70629f1b0ce78e4ed254f6e7165800580a48f962a
    claim_bindings:
      - claim_key: CLAIM-50111E648A1C7A1B
        requirement_id: REQ-AUTO-178AB1F1C5F1EFE0
        fact_id: FACT-PROP-94E1C938A03167B0
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - clause_drop
          operator: includes
---
Source proof for REQ-AUTO-178AB1F1C5F1EFE0. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `clause_drop`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_clause_drop`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
