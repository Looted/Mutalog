---
title: e2e:break_threshold_sets_the_exit_code
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-break-threshold-sets-the-exit-code
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:20.146Z'
id: TEST-e2e-break-threshold-sets-the-exit-code
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-f9e09184945e3b420e267bd0
    test_id: TEST-e2e-break-threshold-sets-the-exit-code
    scope: end_to_end
    outcome: passed
    code_snapshot: 8c382182cf0ed41e201f16a096fef2ad75944e46d7d2ca835c1f878cc233fb12
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T19:11:28.926Z'
    finished_at: '2026-10-29T19:11:31.721Z'
    artifact_digest: d5346c2217ed1e4eb52509870d6933ae0b9d055e50add494046aed7ef5b2f869
    contract_hash: 28437c41b013dc18627b6e44fca6b15d2e21eaa1b5fb876f124ac4ef6792f62a
    binding_hash: 2de6482f696ece908035922ee4af81df7ef2c0bc3523e4cf42957bce0da83b2b
    fingerprint: f81e1fb847c03bff8b0e43842e48af032ad89bee12401e0719c59a32824cf539
    fingerprint_components:
      contract: 28437c41b013dc18627b6e44fca6b15d2e21eaa1b5fb876f124ac4ef6792f62a
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
      - symbol_id: SYM-test-e2e-break-threshold-sets-the-exit-code
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:break_threshold_sets_the_exit_code` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project scoring 67.3%, when break is 90 then mutalog run exits with 1, and when break is 50 it exits with 0.

Run it alone with `swipl test/run.pl e2e:break_threshold_sets_the_exit_code`.
