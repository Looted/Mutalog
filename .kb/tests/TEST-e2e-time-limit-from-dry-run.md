---
title: e2e:time_limit_from_dry_run
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-time-limit-from-dry-run
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:13.363Z'
id: TEST-e2e-time-limit-from-dry-run
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-6af45b43052c2b87138605bb
    test_id: TEST-e2e-time-limit-from-dry-run
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: 72fcf8afe7ea7ba3a481e1708636bbae113c0fd26ff7bc5ee5c7cc367eda7795
    binding_hash: c658fc37ceb939fe78d0484978e5ae9f12f72ab345e5912edef7883c2a7efb2f
    fingerprint: c18ef96bde775ab408f7bbca0e012806d404c31b7d75c08f17d8861472742342
    fingerprint_components:
      contract: 72fcf8afe7ea7ba3a481e1708636bbae113c0fd26ff7bc5ee5c7cc367eda7795
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
      - symbol_id: SYM-test-e2e-time-limit-from-dry-run
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:time_limit_from_dry_run` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project and --timeout-ms 300, when the user runs mutalog run, then the mutant that makes countdown/1 loop is Timeout and the run finishes promptly.

Run it alone with `swipl test/run.pl e2e:time_limit_from_dry_run`.
