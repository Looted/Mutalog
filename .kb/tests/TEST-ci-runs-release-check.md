---
title: CI runs the release check
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-ci-runs-release-check
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: yaml
    file: .github/workflows/ci.yml
    path: jobs.test.steps.2.run
  proves:
    - CLAIM-59378A68EEBBC818
origin:
  kind: agent
  recorded_at: '2026-10-29T18:02:31.517Z'
id: TEST-ci-runs-release-check
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-d5bbbe67cf82d4c7d59d110b
    test_id: TEST-ci-runs-release-check
    scope: integration
    outcome: passed
    code_snapshot: 6b798ab7322821537c2b4ec238cce7db791699f7ef83fa407e794bed47bcf841
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-02T15:37:23.050Z'
    finished_at: '2026-11-02T15:37:36.226Z'
    artifact_digest: 270415ba4c5571466acb539f81f7209a617ae78ce20b3ddb1266e336038e311c
    contract_hash: 12be01041847ffea15993877dec732e804b826a3cbf6ed88d36e2731d1996d35
    binding_hash: f7d689d0f724d710cb190d56760d1c4a1d75a7a4e0bc174acfedb111bba5e6f4
    fingerprint: 23e67050cb15bb166733c4e59171efc212ec10b9e0d760edf6d326695a4f252b
    fingerprint_components:
      contract: 12be01041847ffea15993877dec732e804b826a3cbf6ed88d36e2731d1996d35
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
      - symbol_id: SYM-test-ci-runs-release-check
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: source
    evidence_level: proved
    certificate:
      version: kibi.code-certificate.v1
      kind: source
      test_id: TEST-ci-runs-release-check
      source:
        reader: yaml
        file: .github/workflows/ci.yml
        path: jobs.test.steps.2.run
      model:
        members:
          - scripts/release-check.sh
    certificate_digest: c8708e67f67489b5570ad3cc1cb8e1f7726244783e7fdd0392226e920205cf54
    claim_bindings:
      - claim_key: CLAIM-59378A68EEBBC818
        requirement_id: REQ-release-changelog-matches-pack
        fact_id: FACT-PROP-4E649BA07003BE87
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - scripts/release-check.sh
          operator: includes
---
Source proof that the CI test job runs `scripts/release-check.sh`, so CI fails when pack.pl names a version with no CHANGELOG.md section. The step itself runs the release check on the checkout.

## Context

Kibi reads the `run` command of the release-check step (`jobs.test.steps.2.run`) in `.github/workflows/ci.yml` and checks that it is `scripts/release-check.sh`. The end-to-end test `TEST-e2e-release-check-requires-a-changelog-section` shows that the script fails without the section.
