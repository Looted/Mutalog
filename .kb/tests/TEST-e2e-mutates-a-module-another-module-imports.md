---
title: e2e:mutates_a_module_another_module_imports
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutates-a-module-another-module-imports
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T19:05:43.314Z'
id: TEST-e2e-mutates-a-module-another-module-imports
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-e50fbe1de451e5c8b2babe8c
    test_id: TEST-e2e-mutates-a-module-another-module-imports
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 39a4654c2206bd16f84d251d1d2a5ec3b1545af041c40adba2c80780377152b7
    binding_hash: f903b404841476c82f1c16593e04a175f53b231156ca622f2b3634c56078afa0
    fingerprint: 0edaf734aa6937fd67ccc114e3c8502229a79ece2b4a38435aa3dd157d3df890
    fingerprint_components:
      contract: 39a4654c2206bd16f84d251d1d2a5ec3b1545af041c40adba2c80780377152b7
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
      - symbol_id: SYM-test-e2e-mutates-a-module-another-module-imports
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:mutates_a_module_another_module_imports` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given a project where module b imports module a and both are mutated, when the user runs mutalog run with one worker, then every mutant loads and is killed, the output has no compile errors and the exit code is 0.

Run it alone with `swipl test/run.pl e2e:mutates_a_module_another_module_imports`.