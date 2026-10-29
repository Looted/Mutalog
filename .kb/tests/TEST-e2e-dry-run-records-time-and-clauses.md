---
title: e2e:dry_run_records_time_and_clauses
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-dry-run-records-time-and-clauses
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:07.047Z'
id: TEST-e2e-dry-run-records-time-and-clauses
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-a5ba799413a93c0831d7c811
    test_id: TEST-e2e-dry-run-records-time-and-clauses
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: a9e54def513c1bf0fba4cd4fcb9e9d4da3e75ac959c78c5ef73ad7606ed8fe9d
    binding_hash: 9d9eb82dd7a280a3994e7ecdf388c079eacbac43fae520b563654e5b43be8501
    fingerprint: 530c5366f9676003def020ed2deda710bb5fb5e94d043a11e3ee243abdb0bc5f
    fingerprint_components:
      contract: a9e54def513c1bf0fba4cd4fcb9e9d4da3e75ac959c78c5ef73ad7606ed8fe9d
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
      - symbol_id: SYM-test-e2e-dry-run-records-time-and-clauses
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:dry_run_records_time_and_clauses` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog dry-run, then each test is listed with its time in milliseconds and the number of clauses it entered, and the summary counts 7 tests and 55 mutants.

Run it alone with `swipl test/run.pl e2e:dry_run_records_time_and_clauses`.
