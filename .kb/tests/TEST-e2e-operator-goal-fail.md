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
    receipt_id: PR-878a6b5542130a11573a5ed5
    test_id: TEST-e2e-operator-goal-fail
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
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
