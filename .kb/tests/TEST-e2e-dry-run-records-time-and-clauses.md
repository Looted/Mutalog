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
    receipt_id: PR-ddd3923bbf624d3dcf5d95e1
    test_id: TEST-e2e-dry-run-records-time-and-clauses
    scope: end_to_end
    outcome: passed
    code_snapshot: f0def101d448e3aeaaffb3b4a42d3cf703322ae9e702c99227a2d5169142b1c4
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:26:20.515Z'
    finished_at: '2026-11-02T12:26:23.769Z'
    artifact_digest: 0eb21479dc3d0ace03b9f8a5215344914938124e5fa24ba44ce3e6a2a571298f
    contract_hash: a9e54def513c1bf0fba4cd4fcb9e9d4da3e75ac959c78c5ef73ad7606ed8fe9d
    binding_hash: 546a10b3f2d84692f687745f4909ae44604210b9f4948cdcc789c713a10ca22e
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
