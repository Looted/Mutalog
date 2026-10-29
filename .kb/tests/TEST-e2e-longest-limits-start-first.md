---
title: e2e:longest_limits_start_first
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-longest-limits-start-first
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:17.677Z'
id: TEST-e2e-longest-limits-start-first
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-3da9b1b855bf327a1d77d0c4
    test_id: TEST-e2e-longest-limits-start-first
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: 2bc21a0c353064b1301971880a37b1e80755679ac8ed11b8c758cb8a1643b27a
    binding_hash: 23ae8cdfebe5054212c24ba585f2f126a3f3a76dce0609e0bbe91ace5584ba3d
    fingerprint: ed7e75e65b5454c8ef6551876017d7cce25d100a44ad1e5d53ab79d5c771c3b7
    fingerprint_components:
      contract: 2bc21a0c353064b1301971880a37b1e80755679ac8ed11b8c758cb8a1643b27a
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
      - symbol_id: SYM-test-e2e-longest-limits-start-first
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:longest_limits_start_first` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given one worker and a slow test listed after a fast one, when the user runs mutalog run, then the slow test's mutants run before the fast test's.

Run it alone with `swipl test/run.pl e2e:longest_limits_start_first`.
