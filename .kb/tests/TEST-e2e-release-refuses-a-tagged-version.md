---
title: e2e:release_refuses_a_tagged_version
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-release-refuses-a-tagged-version
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:27.412Z'
id: TEST-e2e-release-refuses-a-tagged-version
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-db75a8f206ecb2990c5d6310
    test_id: TEST-e2e-release-refuses-a-tagged-version
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: 547a68218e4e7c68dded493108b00f88c8afd35e0fbce9d68ffffc29d6a86b3a
    binding_hash: 5b388b4446bb1880168c381f74ec8f9d852a58354118b27342d6c40d0af50717
    fingerprint: f6640bf49d7ef7f8f23c8c4e05d480894e4321662a7c5c18688f88f7b585058f
    fingerprint_components:
      contract: 547a68218e4e7c68dded493108b00f88c8afd35e0fbce9d68ffffc29d6a86b3a
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
      - symbol_id: SYM-test-e2e-release-refuses-a-tagged-version
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:release_refuses_a_tagged_version` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a checkout whose origin has no tag for the version, when release-check.sh --untagged runs it passes; after the tag is pushed, it fails saying the tag already exists.

Run it alone with `swipl test/run.pl e2e:release_refuses_a_tagged_version`.
