---
title: e2e:operator_arith
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-arith
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:51.972Z'
id: TEST-e2e-operator-arith
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-59a9b54a93cf200ca0c00875
    test_id: TEST-e2e-operator-arith
    scope: end_to_end
    outcome: passed
    code_snapshot: 2f6e624f3911adb9cf78f8559299244a7a72fc7e02ca53c4319289bab545b210
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T18:05:48.772Z'
    finished_at: '2026-10-29T18:06:25.804Z'
    artifact_digest: 11c7c63d178616c342276a172c41f3f1f4545f5bd37c1e205f6c5b6c8490153c
    contract_hash: 2a9aa065ffd313d920b5cc9dcf1e47daf4a39175dec284b9cfaf4b556dd1c394
    binding_hash: bb0103b910d12f4d2821023b74c98e792c4aae53017c1f0d41b95de3ea81af17
    fingerprint: c5aba6fab0dc0defc09b525cc8c628e8324a53374e11a5746e8b1dac5c47d742
    fingerprint_components:
      contract: 2a9aa065ffd313d920b5cc9dcf1e47daf4a39175dec284b9cfaf4b556dd1c394
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
      - symbol_id: SYM-test-e2e-operator-arith
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:operator_arith` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the sample fixture, when the user lists arith mutants, then S0 + H becomes S0 - H.

Run it alone with `swipl test/run.pl e2e:operator_arith`.
