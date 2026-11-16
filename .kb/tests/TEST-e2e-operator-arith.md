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
    receipt_id: PR-7636124b5f3a3c6aed1d8312
    test_id: TEST-e2e-operator-arith
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 2a9aa065ffd313d920b5cc9dcf1e47daf4a39175dec284b9cfaf4b556dd1c394
    binding_hash: 8f4003bdc7e2ead3bcc1bcff3c755a19e42afa2812418f45cce228f3c281a5b9
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
