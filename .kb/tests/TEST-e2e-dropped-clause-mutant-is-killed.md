---
title: e2e:dropped_clause_mutant_is_killed
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-dropped-clause-mutant-is-killed
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T19:10:00.450Z'
id: TEST-e2e-dropped-clause-mutant-is-killed
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-16627c37b3084b6a1a956bcf
    test_id: TEST-e2e-dropped-clause-mutant-is-killed
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: be8f247067c23e896313e98cafaf07a778fb2d7c168f6bd659fe4954734a7067
    binding_hash: d8a74dfac70ec2f971b1d4dcf48f7ab0f6c6f720c65859256afa09a0021632ec
    fingerprint: 2fe1e89cd5d8c8f69747dd5e992251fbdb1052c9c028a24d9c32471faaafaef7
    fingerprint_components:
      contract: be8f247067c23e896313e98cafaf07a778fb2d7c168f6bd659fe4954734a7067
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
      - symbol_id: SYM-test-e2e-dropped-clause-mutant-is-killed
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:dropped_clause_mutant_is_killed` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project whose module has a clause that the only test needs, when the user runs mutalog run with one worker and the goal_true and clause_drop operators, then the mutant that drops that clause is killed, although earlier mutants of the same predicate ran in the same worker first.

The SWI-Prolog index bug behind issue #21 shows only in some processes, and this project does not reliably trigger it, so `worker:reload_drops_stale_clauses` remains the regression guard. This test checks the outcome a user sees.

Run it alone with `swipl test/run.pl e2e:dropped_clause_mutant_is_killed`.