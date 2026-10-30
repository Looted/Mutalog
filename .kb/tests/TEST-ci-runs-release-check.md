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
    receipt_id: PR-3b9268d41db2cc0e898357cd
    test_id: TEST-ci-runs-release-check
    scope: integration
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: 12be01041847ffea15993877dec732e804b826a3cbf6ed88d36e2731d1996d35
    binding_hash: 30196239b8710e0a5fe8d90e3fbd5ef625d05884d9fbb9f541f906c02063c242
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
