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
    receipt_id: PR-f37932f488729b8a2a2e524e
    test_id: TEST-e2e-custom-operator-from-a-project
    scope: end_to_end
    outcome: passed
    code_snapshot: 2f6e624f3911adb9cf78f8559299244a7a72fc7e02ca53c4319289bab545b210
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T18:05:48.772Z'
    finished_at: '2026-10-29T18:06:25.804Z'
    artifact_digest: 11c7c63d178616c342276a172c41f3f1f4545f5bd37c1e205f6c5b6c8490153c
    contract_hash: 828a81b68671e455310999bff6e7ea0fa7f9d95b931f68249e4b48d0ec2d70ca
    binding_hash: 0ff68e43ead462569c5a213b9dd51bf57341d0833727aa39f09e48a941195e01
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
