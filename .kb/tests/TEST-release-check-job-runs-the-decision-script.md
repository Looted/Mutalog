---
title: The Release check job runs the release decision script
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-release-check-job-runs-the-decision-script
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: yaml
    file: .github/workflows/release.yml
    path: jobs.check.steps.1.run
  proves:
    - CLAIM-A82CD1DFE24DB66F
origin:
  kind: agent
  recorded_at: '2026-10-30T23:26:19.416Z'
id: TEST-release-check-job-runs-the-decision-script
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-1683dedbc48a93b21ca02882
    test_id: TEST-release-check-job-runs-the-decision-script
    scope: integration
    outcome: passed
    code_snapshot: 92e3954df4f617ded2727621938b06fd4e05ade1fa7b70daf347fa96818d6d78
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T11:39:41.926Z'
    finished_at: '2026-11-02T11:40:29.375Z'
    artifact_digest: 7d01fd058c5eddf0d483e1e7fec068a609ce5e15ae1c3d99860885d6a7727ec2
    contract_hash: 23eabe00579359089b3500072ec5871f4c993a38a6a861e83eb07d0577307be0
    binding_hash: 22c0c7fa99becc3dd7515247700f2675624f21b353fb7a04deaf79e8eac0876b
    fingerprint: f437d45c4d0c560e3fd279099b14109409ea28a60b23e736186b57f70a23ee80
    fingerprint_components:
      contract: 23eabe00579359089b3500072ec5871f4c993a38a6a861e83eb07d0577307be0
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
      - symbol_id: SYM-test-release-check-job-runs-the-decision-script
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
      test_id: TEST-release-check-job-runs-the-decision-script
      source:
        reader: yaml
        file: .github/workflows/release.yml
        path: jobs.check.steps.1.run
      model:
        members:
          - scripts/release-decide.sh
    certificate_digest: 4aa7ccf3f3354d021ab3295814ab9421676e796ff4c8d4bdab3353e3c0199bd3
    claim_bindings:
      - claim_key: CLAIM-A82CD1DFE24DB66F
        requirement_id: REQ-release-refuse-tagged-version
        fact_id: FACT-PROP-34D68E4DFB8A5AAF
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - scripts/release-decide.sh
          operator: includes
---
Source proof that the Release workflow's check job decides whether to release with `scripts/release-decide.sh`.

## Context

Kibi reads the `run` command of the decision step (`jobs.check.steps.1.run`) in `.github/workflows/release.yml` and checks that it is `scripts/release-decide.sh`. The end-to-end test `TEST-e2e-release-refuses-a-tagged-version` shows that the script refuses a version that is already tagged.