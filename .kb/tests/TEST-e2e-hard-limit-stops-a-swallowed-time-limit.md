---
title: e2e:hard_limit_stops_a_swallowed_time_limit
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-hard-limit-stops-a-swallowed-time-limit
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:14.391Z'
id: TEST-e2e-hard-limit-stops-a-swallowed-time-limit
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-e1b1bfdeef86c79dd89f7618
    test_id: TEST-e2e-hard-limit-stops-a-swallowed-time-limit
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: ed15386678a4c6a35d8d769b29339609fb54d334f9384cefb39d1fd87371b8f6
    binding_hash: 0349d943566e7406bafbc1cfbf87ac1fd9ad5f349cd77955440df4139ab6987d
    fingerprint: 4d61eb88cdfc337be084d6b394470c50ae61370879f5fff0a2cdb6cd2f918f7a
    fingerprint_components:
      contract: ed15386678a4c6a35d8d769b29339609fb54d334f9384cefb39d1fd87371b8f6
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
      - symbol_id: SYM-test-e2e-hard-limit-stops-a-swallowed-time-limit
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:hard_limit_stops_a_swallowed_time_limit` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given code that catches every exception and loops again, when the user runs mutalog run, then its mutant is Timeout and the run finishes.

Run it alone with `swipl test/run.pl e2e:hard_limit_stops_a_swallowed_time_limit`.
