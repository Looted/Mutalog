---
title: e2e:pack_needs_only_swi_prolog
status: active
verification_scope: end_to_end
verification_perspective: consumer
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-pack-needs-only-swi-prolog
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T17:51:24.493Z'
id: TEST-e2e-pack-needs-only-swi-prolog
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-c7a58c822b7b2b2384e5b0af
    test_id: TEST-e2e-pack-needs-only-swi-prolog
    scope: end_to_end
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 1f393c0769d725807b9db3786fa1ba4af1e5cab97be84426bec91470f1ccd500
    binding_hash: 11c406d843456c975eb454d82770022c1b39fd4cad71b349630548927ca6faaf
    fingerprint: e8702876661bba286d4809d9327da16e428e576b2a143c77b3f14de86041c847
    fingerprint_components:
      contract: 1f393c0769d725807b9db3786fa1ba4af1e5cab97be84426bec91470f1ccd500
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
      - symbol_id: SYM-test-e2e-pack-needs-only-swi-prolog
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
End-to-end test `e2e:pack_needs_only_swi_prolog` in test/test_e2e.plt. It drives the installed command line or pack the way a user would.

## Context

Given the installed pack, when library(mutalog) is loaded in a fresh swipl, then every file it loads from the pack is Prolog source and pack.pl requires no other pack.

Run it alone with `swipl test/run.pl e2e:pack_needs_only_swi_prolog`.
