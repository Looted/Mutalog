---
title: e2e:applies_mutants_to_static_code
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-applies-mutants-to-static-code
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:12.312Z'
id: TEST-e2e-applies-mutants-to-static-code
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-131395ebdb7b0f4aa91ee457
    test_id: TEST-e2e-applies-mutants-to-static-code
    scope: end_to_end
    outcome: passed
    code_snapshot: 8c382182cf0ed41e201f16a096fef2ad75944e46d7d2ca835c1f878cc233fb12
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T19:11:26.448Z'
    finished_at: '2026-10-29T19:11:28.039Z'
    artifact_digest: e35f15f4f1a578439f52e83d6f2b740a8409352b322e1c069b89060a06b4dd9c
    contract_hash: e0a5fe70528c80cd144558a1fd0a81fefbe25925e18da076fe6d5bb1d19bb734
    binding_hash: e507ea4767194d62b96f9ebdc59beb6a7b327a2025614d41e473d6cb429d59c7
    fingerprint: ae98c104cef12fe1cb93105e49c1fd2d54907431c4a1130786b5c080cac5b1a0
    fingerprint_components:
      contract: e0a5fe70528c80cd144558a1fd0a81fefbe25925e18da076fe6d5bb1d19bb734
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
      - symbol_id: SYM-test-e2e-applies-mutants-to-static-code
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:applies_mutants_to_static_code` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, whose module is static, when the user runs mutalog run, then a mutant of sum/2 is killed and the source file on disk is unchanged.

Run it alone with `swipl test/run.pl e2e:applies_mutants_to_static_code`.
