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
    receipt_id: PR-b0eb92539f455d5722743e4d
    test_id: TEST-e2e-mutates-a-module-another-module-imports
    scope: end_to_end
    outcome: passed
    code_snapshot: 8c382182cf0ed41e201f16a096fef2ad75944e46d7d2ca835c1f878cc233fb12
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-10-29T19:11:18.812Z'
    finished_at: '2026-10-29T19:11:19.363Z'
    artifact_digest: e34c1d3f3eeb6948f95d744a543fe4ffbd3178a58c2f0b31310a7882dc430ab1
    contract_hash: 39a4654c2206bd16f84d251d1d2a5ec3b1545af041c40adba2c80780377152b7
    binding_hash: 68527c29b4bd6a5b09cd13ef74dc12c59af963758f9539f43cbdda74b02d4474
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