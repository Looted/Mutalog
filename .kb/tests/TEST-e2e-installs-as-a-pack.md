---
title: e2e:installs_as_a_pack
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-installs-as-a-pack
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:23.460Z'
id: TEST-e2e-installs-as-a-pack
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-d41383514e043b2ee7569672
    test_id: TEST-e2e-installs-as-a-pack
    scope: end_to_end
    outcome: passed
    code_snapshot: 6b798ab7322821537c2b4ec238cce7db791699f7ef83fa407e794bed47bcf841
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-02T15:37:23.050Z'
    finished_at: '2026-11-02T15:37:36.226Z'
    artifact_digest: 270415ba4c5571466acb539f81f7209a617ae78ce20b3ddb1266e336038e311c
    contract_hash: b24746bfe5ca668f1b34e0fa88ca9ad0e6474d8eab538817f97b712601f9def1
    binding_hash: 5c4582cc84b55d8fc5e796d7d0169c79a95c8868ccb122e2f459903921e5dd4f
    fingerprint: b6aff1b06543ba4be93311c5d82dabab32b02911bf62aef71df942b98ce24e83
    fingerprint_components:
      contract: b24746bfe5ca668f1b34e0fa88ca9ad0e6474d8eab538817f97b712601f9def1
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
      - symbol_id: SYM-test-e2e-installs-as-a-pack
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:installs_as_a_pack` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the pack files of the checkout, when they are installed with pack_install into an empty pack directory, then library(mutalog) runs mutalog list on the example project.

Run it alone with `swipl test/run.pl e2e:installs_as_a_pack`.
