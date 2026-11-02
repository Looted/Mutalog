---
title: The hard limit is 10 seconds after the time limit
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-proof-hard-limit
      target: default
  success_policy: all_required_first_attempt
  kind: arithmetic
  value_source:
    - symbol_id: SYM-run-hard-limit-margin
      export: hard_limit_margin/1
  proves:
    - CLAIM-9689B01275D74ACA
origin:
  kind: agent
  recorded_at: '2026-11-02T14:28:35.214Z'
id: TEST-cert-hard-limit-is-ten-seconds-late
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-5f3fcd18bf61d2be941be749
    test_id: TEST-cert-hard-limit-is-ten-seconds-late
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: 86f88207e35d1891962a351ea411f55398a14499e32fe5a11887475d2369fa34
    binding_hash: 49fcacb0c81e29c19925d4c6dc2b13fa3f3c10d128ef328fff6bfc1d9a8a57ac
    fingerprint: a7a22411833fc1d4322594e28240c23969391b416dfcc1999c27bbbd70b73ee9
    fingerprint_components:
      contract: 86f88207e35d1891962a351ea411f55398a14499e32fe5a11887475d2369fa34
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
      - symbol_id: SYM-proof-hard-limit
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: arithmetic
    evidence_level: proved
    certificate:
      assumptions:
        - operator: eq
          value: 10
      claim:
        operator: eq
        value: 10
      kind: arithmetic
      test_id: TEST-cert-hard-limit-is-ten-seconds-late
      value_type: int
      variable: margin_seconds
      version: kibi.code-certificate.v1
    certificate_digest: c9c278d2ba1a46220b594ae717a2dad545525372e697180b099e4426f38ae69b
    claim_bindings:
      - claim_key: CLAIM-9689B01275D74ACA
        requirement_id: REQ-AUTO-A94EF4A2296AFF54
        fact_id: FACT-PROP-DE32815F73CC4839
        binding: derived
        scope: code
        obligation:
          kind: numeric_constraint
          operator: eq
          value: 10
          value_type: int
          variable: margin_seconds
---
Arithmetic proof for REQ-AUTO-A94EF4A2296AFF54. Kibi reads the constant \`hard_limit_margin/1\` from \`prolog/mutalog/run.pl\`, which \`try_mutant/9\` adds to the time limit to get the hard limit the controller waits for, and decides that it is 10 seconds.
