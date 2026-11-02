---
title: The default operators include cut and cut_insert
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-cut
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-1B3B492641375B1A
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:21.515Z'
id: TEST-cert-default-operators-include-cut-cut-insert
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-640dff75fe2861405e6320a5
    test_id: TEST-cert-default-operators-include-cut-cut-insert
    scope: integration
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: f0b53f064129c1b997375574ce38c0f1ae5a30c98cbc985bc3c0f99b8f8cfa17
    binding_hash: 5f24a22c4dcbd33894ea8db3ac4b248be95c9607c405c53c57ca3ee25feaebf4
    fingerprint: 77b47666a56caf0deb63201b283e23f83ab46ba281f5c9d34c7f40a66ffde429
    fingerprint_components:
      contract: f0b53f064129c1b997375574ce38c0f1ae5a30c98cbc985bc3c0f99b8f8cfa17
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
      - symbol_id: SYM-test-e2e-operator-cut
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
      test_id: TEST-cert-default-operators-include-cut-cut-insert
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
    certificate_digest: ba20ad43b9d800c085c1f94d90cd80e8abd2d24618d9fe85c203595bd66e88f1
    claim_bindings:
      - claim_key: CLAIM-1B3B492641375B1A
        requirement_id: REQ-AUTO-1BE4DE98E4A99F3C
        fact_id: FACT-PROP-9F648F9D683A1D04
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - cut
            - cut_insert
          operator: includes
---
Source proof for REQ-AUTO-1BE4DE98E4A99F3C. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `cut`, `cut_insert`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_cut`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
