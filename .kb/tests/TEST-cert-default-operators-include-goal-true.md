---
title: The default operators include goal_true
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-goal-true
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-3F1CE219296A9664
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:23.680Z'
id: TEST-cert-default-operators-include-goal-true
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-dadd5a0523d4f1e6641f0b71
    test_id: TEST-cert-default-operators-include-goal-true
    scope: integration
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 35eb404d06a24c2cdfc2a1a4b82b760945dec7ac885631ac88e017491f18b86d
    binding_hash: b023323161f124a2ed4264021b9211759c9fa1e591e8956575be6da63541524e
    fingerprint: c95ea054e2b69dea2d9ecfb1963b26f3093943a8595dc355000055b898a17f13
    fingerprint_components:
      contract: 35eb404d06a24c2cdfc2a1a4b82b760945dec7ac885631ac88e017491f18b86d
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
      - symbol_id: SYM-test-e2e-operator-goal-true
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
      test_id: TEST-cert-default-operators-include-goal-true
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
    certificate_digest: 74595054af45bedc5f66cf65967d3a35dddf7db2418e727e22635c959593222d
    claim_bindings:
      - claim_key: CLAIM-3F1CE219296A9664
        requirement_id: REQ-AUTO-2A92238812D104CF
        fact_id: FACT-PROP-619527B0490BA8A8
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - goal_true
          operator: includes
---
Source proof for REQ-AUTO-2A92238812D104CF. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `goal_true`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_goal_true`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
