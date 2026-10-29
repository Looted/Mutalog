---
title: e2e:mostly_compile_errors_fails_the_break
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mostly-compile-errors-fails-the-break
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:16.762Z'
id: TEST-e2e-mostly-compile-errors-fails-the-break
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-ac9929e0192f31f5cf8ad350
    test_id: TEST-e2e-mostly-compile-errors-fails-the-break
    scope: end_to_end
    outcome: passed
    code_snapshot: 8c382182cf0ed41e201f16a096fef2ad75944e46d7d2ca835c1f878cc233fb12
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T19:11:20.293Z'
    finished_at: '2026-10-29T19:11:22.280Z'
    artifact_digest: f0be5af264c2a4d2fdcc09076d436af293d37bdd0d0584d447190147dfe2fcb1
    contract_hash: 93c57fa2f8a21ea6d511e57db93b1b3585e94679448ee07d0a7caeb842f293f7
    binding_hash: 1820c93d6a65f974d422c1a70dd0e276ecf560151072fd83708f21be4312c61b
    fingerprint: 0c29bc4ee89191066550a5537631f9388e7cfc46c25bdb21831ebc75377bc115
    fingerprint_components:
      contract: 93c57fa2f8a21ea6d511e57db93b1b3585e94679448ee07d0a7caeb842f293f7
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
      - symbol_id: SYM-test-e2e-mostly-compile-errors-fails-the-break
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:mostly_compile_errors_fails_the_break` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project in which one module throws whenever it is loaded again, so most mutants do not load, when the user runs mutalog run with break(50), then the run exits with 1, the output lists the compile errors with the first load error, and the JSON report gives that error as statusReason.

Run it alone with `swipl test/run.pl e2e:mostly_compile_errors_fails_the_break`.