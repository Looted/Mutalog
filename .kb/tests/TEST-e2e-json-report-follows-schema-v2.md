---
title: e2e:json_report_follows_schema_v2
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-json-report-follows-schema-v2
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:22.364Z'
id: TEST-e2e-json-report-follows-schema-v2
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-54a8834cf4f83e937116befd
    test_id: TEST-e2e-json-report-follows-schema-v2
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 4beec563fb991eff3f8a736b40757416ceac5097c796da8a819c98f9c8f623cf
    binding_hash: 98776f837c1dc34114d8344097cb2e5a886ca34862d94fea0d5d15151b178a91
    fingerprint: c100529055dbd8ed33fb71e3649bc6f36278e2f23071be678f0b27d97ab53b32
    fingerprint_components:
      contract: 4beec563fb991eff3f8a736b40757416ceac5097c796da8a819c98f9c8f623cf
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
      - symbol_id: SYM-test-e2e-json-report-follows-schema-v2
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:json_report_follows_schema_v2` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the example project, when the user runs mutalog run with the json reporter, then mutation.json has schemaVersion 2, thresholds, the file source and language, and each mutant has an id, mutatorName, location and a schema status.

Run it alone with `swipl test/run.pl e2e:json_report_follows_schema_v2`.
