---
title: e2e:runs_only_covering_tests
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-runs-only-covering-tests
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:11.193Z'
id: TEST-e2e-runs-only-covering-tests
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-03bb2fac01dd944bd45faba2
    test_id: TEST-e2e-runs-only-covering-tests
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: e30af596df10948943a47b261e5c42ad6d51f7b5d345a086e48076f4de3ab46c
    binding_hash: a9a96ca043b200b40cbbf3c5a2794d18179c1d4fcddfdaf617d36816893b2a23
    fingerprint: c6420e7fda645fde59d9c2598e5b8d381d7b54ee4d5af6786ae9ae2833d4430e
    fingerprint_components:
      contract: e30af596df10948943a47b261e5c42ad6d51f7b5d345a086e48076f4de3ab46c
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
      - symbol_id: SYM-test-e2e-runs-only-covering-tests
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:runs_only_covering_tests` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog run, then the mutant in sum/2 is killed by calc:sum and covered by calc:sum only.

Run it alone with `swipl test/run.pl e2e:runs_only_covering_tests`.
