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
    receipt_id: PR-7298c4410bd8633ed4f6a412
    test_id: TEST-e2e-dropped-clause-mutant-is-killed
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: be8f247067c23e896313e98cafaf07a778fb2d7c168f6bd659fe4954734a7067
    binding_hash: 54b6302e76dcfa6843cdaaac3cdaeb24e5365392b4247c62c54348fb5ec7ce37
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