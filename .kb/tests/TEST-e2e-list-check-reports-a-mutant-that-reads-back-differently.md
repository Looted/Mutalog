---
title: e2e:list_check_reports_a_mutant_that_reads_back_differently
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-list-check-reports-a-mutant-that-reads-back-differently
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-11-02T12:20:15.662Z'
id: TEST-e2e-list-check-reports-a-mutant-that-reads-back-differently
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-7ce3121ffda2945684530e05
    test_id: TEST-e2e-list-check-reports-a-mutant-that-reads-back-differently
    scope: end_to_end
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: 98d9c7e08d62905c6cb16d6223f205db140cea797a18a8efe6b08143f8197e39
    binding_hash: d602ba381386f5d37ac95c215f4ac29a55991035128d583e3d8721b14a49ce29
    fingerprint: 66e974066426ab443d571b9278bf71b8e99760fa7c221f6d387fe34be168443b
    fingerprint_components:
      contract: 98d9c7e08d62905c6cb16d6223f205db140cea797a18a8efe6b08143f8197e39
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
      - symbol_id: SYM-test-e2e-list-check-reports-a-mutant-that-reads-back-differently
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:list_check_reports_a_mutant_that_reads_back_differently` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project with a custom operator whose mutant prints as text that reads back as a different clause, when the user runs mutalog list --check --format json, then every such mutant reports a mismatch and the command exits 1.

Run it alone with `swipl test/run.pl e2e:list_check_reports_a_mutant_that_reads_back_differently`.
