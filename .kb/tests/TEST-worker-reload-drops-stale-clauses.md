---
title: worker:reload_drops_stale_clauses
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-worker-reload-drops-stale-clauses
      target: default
  success_policy: all_required_first_attempt
origin:
  kind: agent
  recorded_at: '2026-10-29T19:06:22.844Z'
id: TEST-worker-reload-drops-stale-clauses
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-c1c244460746118058d3bb3c
    test_id: TEST-worker-reload-drops-stale-clauses
    scope: integration
    outcome: passed
    code_snapshot: ea7e4409e73c6b80135531d98ea370cff5187a29b01e614a39e0b42f4bda30bb
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-02T15:38:33.531Z'
    finished_at: '2026-11-02T15:38:38.858Z'
    artifact_digest: b1ec2ea61f028ca30ad3bdf603420b741f71018b202adf1c8b3a9eb36f3aae61
    contract_hash: 587c91212cd4b2b10fcaafe37195a47c5f23844e504359c4d664195415d547da
    binding_hash: da765746a23c791c546771073dd71bb076c094ccf56761d9a626014ce6e162f8
    fingerprint: 2333fc58f10e6bd345abab65225b1088d9a29992ea70b4386c159b8953b4507f
    fingerprint_components:
      contract: 587c91212cd4b2b10fcaafe37195a47c5f23844e504359c4d664195415d547da
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
      - symbol_id: SYM-test-worker-reload-drops-stale-clauses
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: e2e
    evidence_level: tested
---
Test `worker:reload_drops_stale_clauses` in test/test_mutalog.plt. It runs test/reload_scenario.pl in several fresh swipl processes.

## Context

Given a module that is reloaded over a previous version of itself, the way the worker applies one mutant after another, when a clause that ran after the first reload is dropped by the second, then calls no longer reach the dropped clause, checked in several fresh processes.

Run it alone with `swipl test/run.pl worker:reload_drops_stale_clauses`.