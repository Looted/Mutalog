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
    receipt_id: PR-2b9c1a5295fbd68374dd87e0
    test_id: TEST-e2e-mutant-ids-name-file-line-column-operator
    scope: end_to_end
    outcome: passed
    code_snapshot: 2f6e624f3911adb9cf78f8559299244a7a72fc7e02ca53c4319289bab545b210
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T18:05:48.772Z'
    finished_at: '2026-10-29T18:06:25.804Z'
    artifact_digest: 11c7c63d178616c342276a172c41f3f1f4545f5bd37c1e205f6c5b6c8490153c
    contract_hash: afa81f5e82129b6fdd30223d8a9115c50ef916b64ae51c397f3b062e0a303ec7
    binding_hash: d88222f490a368661f467ee6386528322acfda19cfd63c08c139be6421901a5e
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
