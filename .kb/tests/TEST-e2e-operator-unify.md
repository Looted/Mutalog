---
title: e2e:operator_unify
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-unify
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:53.911Z'
id: TEST-e2e-operator-unify
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-e732374f25306f8f2d5ac8ee
    test_id: TEST-e2e-operator-unify
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: 337478e4217bedeafec3a6648ff642a0c169b6edd62764df69f85c38162d48a3
    binding_hash: 19193a9b718e0cdb5d41bde5b26b09616a36a47217ca2c5609f59c33a0160fc5
    fingerprint: 707471e0c28a5872268338aff5a0fde1a71a2f988c4ecf4abbf37e9238f3ff9a
    fingerprint_components:
      contract: 337478e4217bedeafec3a6648ff642a0c169b6edd62764df69f85c38162d48a3
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
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:operator_unify` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the sample fixture, when the user lists unify mutants, then Value = none becomes Value \= none and X == off becomes X \== off.

Run it alone with `swipl test/run.pl e2e:operator_unify`.
