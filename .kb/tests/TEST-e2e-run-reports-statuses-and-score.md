---
title: e2e:run_reports_statuses_and_score
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-run-reports-statuses-and-score
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:09.117Z'
id: TEST-e2e-run-reports-statuses-and-score
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-c3780cb5899e65c8b7aaf369
    test_id: TEST-e2e-run-reports-statuses-and-score
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: f5fbe542b3c4b8fa249e24d282591ca89494dea5f503cbf020cdad7625afc390
    binding_hash: 26ff272ab25b719f59e7f574aa5131043b9ee5076a2797db21249a93a535d0a5
    fingerprint: 3e84855f8bb8a34f429bd529709b103bc1c1cba8cfd8be2327ff5b9c9bf182fd
    fingerprint_components:
      contract: f5fbe542b3c4b8fa249e24d282591ca89494dea5f503cbf020cdad7625afc390
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
      - symbol_id: SYM-test-e2e-run-reports-statuses-and-score
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:run_reports_statuses_and_score` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog run, then the report holds 35 killed, 12 survived, 2 timed out and 6 uncovered mutants and the score is 67.3%.

Run it alone with `swipl test/run.pl e2e:run_reports_statuses_and_score`.
