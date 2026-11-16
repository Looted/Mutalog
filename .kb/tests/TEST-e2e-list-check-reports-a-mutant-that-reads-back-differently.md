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
    receipt_id: PR-2944d67f1d64211aacf04aa5
    test_id: TEST-e2e-list-check-reports-a-mutant-that-reads-back-differently
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 98d9c7e08d62905c6cb16d6223f205db140cea797a18a8efe6b08143f8197e39
    binding_hash: defc6f6c8312345c8ec2907555bfc271848035def13127c99cbbec6fcac838ea
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
