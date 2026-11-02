---
title: e2e:mutant_ids_name_file_line_column_operator
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutant-ids-name-file-line-column-operator
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:50.914Z'
id: TEST-e2e-mutant-ids-name-file-line-column-operator
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-534ab7c1275d0a725c1bba72
    test_id: TEST-e2e-mutant-ids-name-file-line-column-operator
    scope: end_to_end
    outcome: passed
    code_snapshot: f0def101d448e3aeaaffb3b4a42d3cf703322ae9e702c99227a2d5169142b1c4
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:26:20.515Z'
    finished_at: '2026-11-02T12:26:23.769Z'
    artifact_digest: 0eb21479dc3d0ace03b9f8a5215344914938124e5fa24ba44ce3e6a2a571298f
    contract_hash: afa81f5e82129b6fdd30223d8a9115c50ef916b64ae51c397f3b062e0a303ec7
    binding_hash: 0d213b472ad630da71a67cda9e888fe525242968b89634698f7ff6fe613cb28b
    fingerprint: ea0cebf14423809748ef2c720d85d03f55ae0a7b3f85c0bd28e264ce1d0f5a40
    fingerprint_components:
      contract: afa81f5e82129b6fdd30223d8a9115c50ef916b64ae51c397f3b062e0a303ec7
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
      - symbol_id: SYM-test-e2e-mutant-ids-name-file-line-column-operator
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:mutant_ids_name_file_line_column_operator` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user lists the mutants as JSON, then each id splits into the file path, the start line and column, the operator and a number, and all 55 ids are unique.

Run it alone with `swipl test/run.pl e2e:mutant_ids_name_file_line_column_operator`.
