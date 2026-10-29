---
title: e2e:failing_test_stops_the_run
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-failing-test-stops-the-run
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:08.129Z'
id: TEST-e2e-failing-test-stops-the-run
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-62238f77dc559b84be0fa1e9
    test_id: TEST-e2e-failing-test-stops-the-run
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: 880a2f95d03a9fd06a56aeef66b0c9ec162ff68951fa8e7468ab680c9abf1370
    binding_hash: 6310b3e55d079c4e1525cf67e97597b2222890087888cd6a8f719690f5400fb9
    fingerprint: 9b260489a9cacac359f540bcc4faabb9c092befe449127e3df1143bc2eba0c8c
    fingerprint_components:
      contract: 880a2f95d03a9fd06a56aeef66b0c9ec162ff68951fa8e7468ab680c9abf1370
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
      - symbol_id: SYM-test-e2e-failing-test-stops-the-run
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:failing_test_stops_the_run` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project whose test fails on the unmutated code, when the user runs mutalog run, then it exits with 2, names the failing test and writes no report.

Run it alone with `swipl test/run.pl e2e:failing_test_stops_the_run`.
