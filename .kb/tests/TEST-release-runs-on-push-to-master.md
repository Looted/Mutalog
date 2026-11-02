---
title: The Release workflow runs on pushes to master
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-release-runs-on-push-to-master
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: yaml
    file: .github/workflows/release.yml
    path: on.push.branches
  proves:
    - CLAIM-2FAB61E2DF9A414C
origin:
  kind: agent
  recorded_at: '2026-10-30T23:26:18.554Z'
id: TEST-release-runs-on-push-to-master
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-f9a5b7d3cda112208362e06b
    test_id: TEST-release-runs-on-push-to-master
    scope: integration
    outcome: passed
    code_snapshot: 92e3954df4f617ded2727621938b06fd4e05ade1fa7b70daf347fa96818d6d78
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T11:39:41.926Z'
    finished_at: '2026-11-02T11:40:29.375Z'
    artifact_digest: 7d01fd058c5eddf0d483e1e7fec068a609ce5e15ae1c3d99860885d6a7727ec2
    contract_hash: b236576c6b2a1a5d1063eb18b50879dc9816993595cca7862f95aefcdd49c449
    binding_hash: 7c4aa110ca87896ef6a1e57898ee26802cdccbab42a8fa2a85cfa0c27630cf05
    fingerprint: 232ab9c36df99e832c9c2cfa3e82d13f47b011751da0f20cdc96d86c1e9e55ea
    fingerprint_components:
      contract: b236576c6b2a1a5d1063eb18b50879dc9816993595cca7862f95aefcdd49c449
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
      - symbol_id: SYM-test-release-runs-on-push-to-master
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
      test_id: TEST-release-runs-on-push-to-master
      source:
        reader: yaml
        file: .github/workflows/release.yml
        path: on.push.branches
      model:
        members:
          - master
        sequence:
          - master
    certificate_digest: fd7094f44eed11d86c33d4aa9d4c240715d799cf0c7eae1e93afaf56f74bd788
    claim_bindings:
      - claim_key: CLAIM-2FAB61E2DF9A414C
        requirement_id: REQ-release-on-merge-to-master
        fact_id: FACT-PROP-C7FEABC2C80B3488
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - master
          operator: includes
---
Source proof that the Release workflow is triggered by pushes to master.

## Context

Kibi reads `on.push.branches` in `.github/workflows/release.yml` and checks that it includes `master`. The end-to-end test `TEST-e2e-release-on-push-to-master-with-an-untagged-version` shows that such a push with an untagged version decides to release.