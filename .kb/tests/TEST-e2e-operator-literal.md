---
title: e2e:operator_literal
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-literal
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:00.456Z'
id: TEST-e2e-operator-literal
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-4ff83a4862955abb6e51bbe9
    test_id: TEST-e2e-operator-literal
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 44a19cf0b359bc4964bd39a1f3d6e23113eb31684f9c722ad64ba5c71a602316
    binding_hash: 1fb97c74168aef9d396e161294077c8fbfc7f405acaf718d8e702b300c3c821c
    fingerprint: 78fbf7e53aee4cf73ab1b745a45da8827ce610bfa6b2ab43117e40ce025732f3
    fingerprint_components:
      contract: 44a19cf0b359bc4964bd39a1f3d6e23113eb31684f9c722ad64ba5c71a602316
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
      - symbol_id: SYM-test-e2e-operator-literal
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:operator_literal` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the sample fixture, when the user lists literal mutants, then 10 becomes 11 and -10, [] becomes [_] and 0 becomes 1.

Run it alone with `swipl test/run.pl e2e:operator_literal`.
