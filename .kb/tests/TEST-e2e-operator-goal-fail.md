---
title: e2e:operator_goal_fail
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-goal-fail
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:50:58.399Z'
id: TEST-e2e-operator-goal-fail
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-a2e46c95985f6c6045ca8afc
    test_id: TEST-e2e-operator-goal-fail
    scope: end_to_end
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
    contract_hash: f5c4f16235359575add978b07e194c9c182c159633dddbaf0e75dc296a4a2e7f
    binding_hash: 00024fab946f28f47e45aaa98c82bfea22bc935ff1bf1594974a0417105b6d8e
    fingerprint: 5bee1385994d123a933f9a906f2ad33b1cd21637c40eca086c965f80a140a3b8
    fingerprint_components:
      contract: f5c4f16235359575add978b07e194c9c182c159633dddbaf0e75dc296a4a2e7f
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
      - symbol_id: SYM-test-e2e-operator-goal-fail
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:operator_goal_fail` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the sample fixture, when the user lists goal_fail mutants, then body goals such as total(T, S0) become fail.

Run it alone with `swipl test/run.pl e2e:operator_goal_fail`.
