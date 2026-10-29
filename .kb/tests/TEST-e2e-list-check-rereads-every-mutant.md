---
title: e2e:list_check_rereads_every_mutant
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-list-check-rereads-every-mutant
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:49.904Z'
id: TEST-e2e-list-check-rereads-every-mutant
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-cbf1f612ee11257a537fb3e7
    test_id: TEST-e2e-list-check-rereads-every-mutant
    scope: end_to_end
    outcome: passed
    code_snapshot: 2f6e624f3911adb9cf78f8559299244a7a72fc7e02ca53c4319289bab545b210
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T18:05:48.772Z'
    finished_at: '2026-10-29T18:06:25.804Z'
    artifact_digest: 11c7c63d178616c342276a172c41f3f1f4545f5bd37c1e205f6c5b6c8490153c
    contract_hash: 8890526cda99d06fbd88a717fbc0acfa885ffdb2c0ee9be35542aa5776562d6f
    binding_hash: 7517c5c6d4be6d8de58d6a6c55864e39d1741ed96c0ccf91a190e556b0e71936
    fingerprint: 125fbf467a6aafcebd86c74422a5d1315e921479038992595d179f62b80b32ba
    fingerprint_components:
      contract: 8890526cda99d06fbd88a717fbc0acfa885ffdb2c0ee9be35542aa5776562d6f
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
      - symbol_id: SYM-test-e2e-list-check-rereads-every-mutant
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:list_check_rereads_every_mutant` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog list --check --format json, then all 55 mutants report check ok.

Run it alone with `swipl test/run.pl e2e:list_check_rereads_every_mutant`.
