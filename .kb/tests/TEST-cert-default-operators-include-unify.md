---
title: The default operators include unify
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-unify
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-BBED0C10E1FCEB15
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:30.285Z'
id: TEST-cert-default-operators-include-unify
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-2acf2669a21ea86f302fa6db
    test_id: TEST-cert-default-operators-include-unify
    scope: integration
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 6b90e142d9a57d32976e69597d988187c19db2ce68ae9ff95f120db51e482187
    binding_hash: 5d61b3e8fab67858389522de22a41cc331608682b9b79cd1a928e2bf55fb0a3e
    fingerprint: 99efa9ac23da9b2e3f11f5be9cd823e39ee55e1c6611dda932049b1b80a5458d
    fingerprint_components:
      contract: 6b90e142d9a57d32976e69597d988187c19db2ce68ae9ff95f120db51e482187
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
      - symbol_id: SYM-test-e2e-operator-unify
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
      test_id: TEST-cert-default-operators-include-unify
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
    certificate_digest: be89c1046c144b23cb59aa94c2d933d6a2e81486bd5592744c61846e347d7b44
    claim_bindings:
      - claim_key: CLAIM-BBED0C10E1FCEB15
        requirement_id: REQ-AUTO-7F9EBE3BDABCE064
        fact_id: FACT-PROP-1CEC6900C832E42A
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - unify
          operator: includes
---
Source proof for REQ-AUTO-7F9EBE3BDABCE064. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `unify`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_unify`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
