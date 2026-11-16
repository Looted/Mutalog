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
    receipt_id: PR-b1363d922f5a81380a5b0148
    test_id: TEST-e2e-version-step-syncs-pack-and-changelog
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: b481e46c61b6b981148ae8ef21922199b37f2cfe49e0f0a3b60707d7f923b1c7
    binding_hash: e7889a1f076fc546dfa9279e8c8ca420b307fc7eb497846bcaaa081db77a74db
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