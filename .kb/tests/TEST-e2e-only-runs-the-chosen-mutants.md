---
title: e2e:only_runs_the_chosen_mutants
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-only-runs-the-chosen-mutants
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:18.956Z'
id: TEST-e2e-only-runs-the-chosen-mutants
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-a3bd46046d9f750a94ffa095
    test_id: TEST-e2e-only-runs-the-chosen-mutants
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: b675cbbdf72afb63180d44120f1f45385508564f9b08779424a41a06ea06abeb
    binding_hash: 3037999e8339b41b7f70f03a4b4c149ae0ca9112a12d0f092ddfe8086962f7a0
    fingerprint: 23d782ffe97ef702a13e81e1aa6e2e256bd93e65319f4ecee96efbd09e1573cc
    fingerprint_components:
      contract: b675cbbdf72afb63180d44120f1f45385508564f9b08779424a41a06ea06abeb
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
      - symbol_id: SYM-test-e2e-only-runs-the-chosen-mutants
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:only_runs_the_chosen_mutants` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog run --only with one mutant id, then the report holds just that mutant, killed.

Run it alone with `swipl test/run.pl e2e:only_runs_the_chosen_mutants`.
