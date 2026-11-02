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
    receipt_id: PR-84851759835edcc53bc9f424
    test_id: TEST-e2e-break-threshold-sets-the-exit-code
    scope: end_to_end
    outcome: passed
    code_snapshot: 6b798ab7322821537c2b4ec238cce7db791699f7ef83fa407e794bed47bcf841
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-02T15:37:23.050Z'
    finished_at: '2026-11-02T15:37:36.226Z'
    artifact_digest: 270415ba4c5571466acb539f81f7209a617ae78ce20b3ddb1266e336038e311c
    contract_hash: 28437c41b013dc18627b6e44fca6b15d2e21eaa1b5fb876f124ac4ef6792f62a
    binding_hash: 59645f19976e0b6ffa877bb12f40303f9d62b7593e5b744a140cdfe0b27377c5
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
