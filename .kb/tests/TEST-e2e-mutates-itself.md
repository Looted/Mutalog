---
title: e2e:mutates_itself
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutates-itself
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:04.826Z'
id: TEST-e2e-mutates-itself
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-d319e8e569fe2af9fea11fc8
    test_id: TEST-e2e-mutates-itself
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: e65ff66824a36faf35bc19bf921b3f7709f5e5e7147a88e8d429dba5874a16bb
    binding_hash: 30320a3b7c3a2b93b99a83b9ac85e425fa1162861d4b127d653faeea6ba9d314
    fingerprint: 061893ee992f4003ff116d88359ed9e608c8946ed854dc3f03582e251834cb89
    fingerprint_components:
      contract: e65ff66824a36faf35bc19bf921b3f7709f5e5e7147a88e8d429dba5874a16bb
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
      - symbol_id: SYM-test-e2e-mutates-itself
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:mutates_itself` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the Mutalog checkout, whose tests run with plunit, when the user runs mutalog list on prolog/**/*.pl with --check, then every mutant of Mutalog itself re-reads correctly.

Run it alone with `swipl test/run.pl e2e:mutates_itself`.
