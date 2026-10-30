---
title: e2e:version_step_syncs_pack_and_changelog
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-version-step-syncs-pack-and-changelog
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-30T13:58:23.090Z'
id: TEST-e2e-version-step-syncs-pack-and-changelog
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-afd8b8d5d5f5203e469a775d
    test_id: TEST-e2e-version-step-syncs-pack-and-changelog
    scope: end_to_end
    outcome: passed
    code_snapshot: 561040e6f209374a9d8fb9a83235a719749eb1f45f1178a36c29249a085678e5
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:31:28.745Z'
    finished_at: '2026-10-30T23:31:29.194Z'
    artifact_digest: cff371e140a96ce32100a5c3beec1738aab67eb70b843fef28d29d1457de47b3
    contract_hash: b481e46c61b6b981148ae8ef21922199b37f2cfe49e0f0a3b60707d7f923b1c7
    binding_hash: 8c968b81a0c29bc1d09b4eb11681a282eadc083e3349892400c9253415d0bd41
    fingerprint: 04e8ae374b2e2d7ff26b7319f35608fcc9431fea4934750eba1138580d4d0bee
    fingerprint_components:
      contract: b481e46c61b6b981148ae8ef21922199b37f2cfe49e0f0a3b60707d7f923b1c7
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
      - symbol_id: SYM-test-e2e-version-step-syncs-pack-and-changelog
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:version_step_syncs_pack_and_changelog` in test/test_e2e.plt. It runs the release scripts as separate processes, the way a release pull request does.

## Context

Given a checkout where package.json has a new version and CHANGELOG.md has the section `changeset version` writes, scripts/sync-version.mjs must carry the version into pack.pl and give the section the layout of the others.

Run it alone with `swipl test/run.pl e2e:version_step_syncs_pack_and_changelog`.