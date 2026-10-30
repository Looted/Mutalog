---
title: e2e:release_on_push_to_master_with_an_untagged_version
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-release-on-push-to-master-with-an-untagged-version
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-30T23:26:17.701Z'
id: TEST-e2e-release-on-push-to-master-with-an-untagged-version
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-f11076d7d943dffc86e08a96
    test_id: TEST-e2e-release-on-push-to-master-with-an-untagged-version
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: 7b84a727b98290766e5c48e05795d070398fb6605d06bcd35dbbc3f7392d306a
    binding_hash: ce6de2cca28f3aa977e41fd6ebd7274843b499389c3890befe38c8dede443066
    fingerprint: 2234133104026001572c9f283d5bb37832ac956da3950fa9630d6d67088aec12
    fingerprint_components:
      contract: 7b84a727b98290766e5c48e05795d070398fb6605d06bcd35dbbc3f7392d306a
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
      - symbol_id: SYM-test-e2e-release-on-push-to-master-with-an-untagged-version
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
Runs `scripts/release-decide.sh` in a release checkout with a local bare origin, as the Release workflow's check job does: a push to master with an untagged version outputs release=true, a push to another branch fails, and a push to master once the tag exists outputs release=false.

## Context

Proves the decision half of REQ-release-on-merge-to-master; publishing itself needs GitHub and the pack server and runs only in the Release workflow.