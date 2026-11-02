---
title: e2e:list_prints_mutants_without_running
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-list-prints-mutants-without-running
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:48.760Z'
id: TEST-e2e-list-prints-mutants-without-running
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-e94f74746ec3d0f1fa2620a0
    test_id: TEST-e2e-list-prints-mutants-without-running
    scope: end_to_end
    outcome: passed
    code_snapshot: 6b798ab7322821537c2b4ec238cce7db791699f7ef83fa407e794bed47bcf841
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-02T15:37:23.050Z'
    finished_at: '2026-11-02T15:37:36.226Z'
    artifact_digest: 270415ba4c5571466acb539f81f7209a617ae78ce20b3ddb1266e336038e311c
    contract_hash: a7b7066042a6c972c15ffc61ef32a84295fe90a9133db23d9a864182b3bbad81
    binding_hash: c5b27614727cda594fc1a8758247ea4311eb94ba2ae6eb4522156a664dde1ab0
    fingerprint: b24948c1866ba79987e21197bf11bc4c7f55ad12b03475f93e8c3cc6c4d25207
    fingerprint_components:
      contract: a7b7066042a6c972c15ffc61ef32a84295fe90a9133db23d9a864182b3bbad81
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
      - symbol_id: SYM-test-e2e-list-prints-mutants-without-running
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:list_prints_mutants_without_running` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog list, then every mutant is printed with its change and no report directory is created, because no test ran.

Run it alone with `swipl test/run.pl e2e:list_prints_mutants_without_running`.
