---
title: e2e:mutates_modules_that_export_the_same_name
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutates-modules-that-export-the-same-name
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:10.666Z'
id: TEST-e2e-mutates-modules-that-export-the-same-name
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-5e7e1d2a6673654d2c68f822
    test_id: TEST-e2e-mutates-modules-that-export-the-same-name
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: 1ed2b4162759352daa7c6b5d8707aad37763eaa43ab4938b024eec1f6b260a20
    binding_hash: d530a94cc9f271c80e1b7cc3e77f76d92eab4b43b6aeb1cb04224c58d4ba3d76
    fingerprint: a31f578b5da24d6baba4c359b25f3ac115a7de593ac6ddd766f0345db7b31a7b
    fingerprint_components:
      contract: 1ed2b4162759352daa7c6b5d8707aad37763eaa43ab4938b024eec1f6b260a20
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
      - symbol_id: SYM-test-e2e-mutates-modules-that-export-the-same-name
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:mutates_modules_that_export_the_same_name` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project with two mutated modules that both export f/2, when the user runs mutalog run with one worker, then every mutant of both modules loads and is killed and the exit code is 0.

Run it alone with `swipl test/run.pl e2e:mutates_modules_that_export_the_same_name`.