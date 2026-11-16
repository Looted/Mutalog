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
    receipt_id: PR-923bc424120bb0b521124f50
    test_id: TEST-e2e-release-refuses-a-tagged-version
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 547a68218e4e7c68dded493108b00f88c8afd35e0fbce9d68ffffc29d6a86b3a
    binding_hash: 4f576f40552cb700c6076d026fb04202673d7cf4e8f9063c1d6dd4ad77c22d8c
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
