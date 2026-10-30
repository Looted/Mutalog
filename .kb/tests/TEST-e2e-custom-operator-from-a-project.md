---
title: e2e:custom_operator_from_a_project
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-custom-operator-from-a-project
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:01.577Z'
id: TEST-e2e-custom-operator-from-a-project
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-300fed51916a9604ffb38617
    test_id: TEST-e2e-custom-operator-from-a-project
    scope: end_to_end
    outcome: passed
    code_snapshot: 90d4af388cfd416a121a101f9f4ea68965d3e4f78fdea212eaa6728422b3826f
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-30T23:27:42.636Z'
    finished_at: '2026-10-30T23:28:23.412Z'
    artifact_digest: 464f24c2c41bc0dd0be75d154d606f32803256203b320e487651079547933a70
    contract_hash: 828a81b68671e455310999bff6e7ea0fa7f9d95b931f68249e4b48d0ec2d70ca
    binding_hash: c8ab0938324920a14f877a6442731573027a9c47e2206b0d610482883150118c
    fingerprint: e3f8fd8d19a6b47460aecaf07c254692464320e26e5d71642178deaaf6a9bddb
    fingerprint_components:
      contract: 828a81b68671e455310999bff6e7ea0fa7f9d95b931f68249e4b48d0ec2d70ca
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
      - symbol_id: SYM-test-e2e-custom-operator-from-a-project
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:custom_operator_from_a_project` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project that defines mutalog:operator/2 and mutalog:mutate/4 clauses for always_true, when it runs mutalog list with --operators always_true, then every mutant comes from that operator.

Run it alone with `swipl test/run.pl e2e:custom_operator_from_a_project`.
