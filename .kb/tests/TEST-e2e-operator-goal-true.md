---
title: e2e:operator_goal_true
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-goal-true
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:57.179Z'
id: TEST-e2e-operator-goal-true
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-4da6426efb2270a9c44815cf
    test_id: TEST-e2e-operator-goal-true
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: 9d49f866e0009ac710ad116c984be5323a02c6cf1146551789851b4217fa6e33
    binding_hash: 4c0e290c7e5a16bf254bb1dd457a18e4abbe9f8751eff04987ba7e104a6f0d38
    fingerprint: 0b8dd9111bed8ee2216f028b617189c42db446be9a73733581c42c57fc7b7d61
    fingerprint_components:
      contract: 9d49f866e0009ac710ad116c984be5323a02c6cf1146551789851b4217fa6e33
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
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:operator_goal_true` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the sample fixture, when the user lists goal_true mutants, then body goals such as total(T, S0) become true.

Run it alone with `swipl test/run.pl e2e:operator_goal_true`.
