---
title: e2e:config_file_is_optional_and_read
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-config-file-is-optional-and-read
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:05.910Z'
id: TEST-e2e-config-file-is-optional-and-read
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-f430494ffd2fea4b77401676
    test_id: TEST-e2e-config-file-is-optional-and-read
    scope: end_to_end
    outcome: passed
    code_snapshot: a95ee68a2a610c0c668098b10a28caaf9741529d5976f0236818875d4a98802a
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T17:54:05.698Z'
    finished_at: '2026-10-29T17:54:42.477Z'
    artifact_digest: 6513638fbbfa44a19362a4a5642caa03e2f48271d15b8303e0d16b7274d5e932
    contract_hash: fdafe6d2b2790e6e9765945897d6bde7a84a06802256eb6e75ddb18c84d6cb1f
    binding_hash: e1230367d8465b160832d965a5cd3fff9b6c4e63a61ea20ecd069670061f18df
    fingerprint: e1ccf77c488feebccfe66aea36aa153f79bb93d07d7ab5651bbb6ab8fcdfd0a5
    fingerprint_components:
      contract: fdafe6d2b2790e6e9765945897d6bde7a84a06802256eb6e75ddb18c84d6cb1f
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
      - symbol_id: SYM-test-e2e-config-file-is-optional-and-read
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:config_file_is_optional_and_read` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project without mutalog.config.pl, when the user lists with --mutate, then all 55 mutants are found; when a config naming only arith is added, then only the 2 arith mutants are listed.

Run it alone with `swipl test/run.pl e2e:config_file_is_optional_and_read`.
