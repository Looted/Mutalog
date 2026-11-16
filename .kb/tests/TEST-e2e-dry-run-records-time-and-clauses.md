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
    receipt_id: PR-0687a4c91d1f3df8696baaf6
    test_id: TEST-e2e-dry-run-records-time-and-clauses
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: a9e54def513c1bf0fba4cd4fcb9e9d4da3e75ac959c78c5ef73ad7606ed8fe9d
    binding_hash: 63fefa1185974c5275998ff849e27aaf9f58fa7b5a3a329d047b7e53f935e515
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
