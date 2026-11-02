---
title: mutation.json declares schema version 2
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-proof-report-schema
      target: default
  success_policy: all_required_first_attempt
  kind: regex
  pattern_source:
    symbol_id: SYM-report-schema-version
    export: report_schema_version/1
  proves:
    - CLAIM-435F0DED4CBD57E9
origin:
  kind: agent
  recorded_at: '2026-11-02T14:28:37.734Z'
id: TEST-cert-report-schema-version-2
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-2184a87df5a6889db3c609f8
    test_id: TEST-cert-report-schema-version-2
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: a60513eb4a17845e050ff6363e0d9a3a19d82163028800900598155aa8e2d1a8
    binding_hash: ad8a836bac2fa400f08418c797498c2dd487140be3e8ed629ac73a5e8946d7c7
    fingerprint: 88b1e6a635f8fcdc2d1c0d10e6586e566ba1270f25087a2b15e3e48fd930b093
    fingerprint_components:
      contract: a60513eb4a17845e050ff6363e0d9a3a19d82163028800900598155aa8e2d1a8
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
      - symbol_id: SYM-proof-report-schema
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: regex
    evidence_level: proved
    certificate:
      kind: regex
      pattern:
        symbol_id: SYM-report-schema-version
        type: string
        value: '2'
      test_id: TEST-cert-report-schema-version-2
      version: kibi.code-certificate.v1
    certificate_digest: 19a991c79cdbc36a64312b20e503dda970cf35b6fb95ad2082a3503ff041729d
    claim_bindings:
      - claim_key: CLAIM-435F0DED4CBD57E9
        requirement_id: REQ-AUTO-20DC4E062C4C1FC7
        fact_id: FACT-PROP-64F5FBD5A2525D99
        binding: derived
        scope: code
        obligation:
          kind: string_constraint
          operator: eq
          polarity: require
          value: '2'
---
Regex proof for REQ-AUTO-20DC4E062C4C1FC7. Kibi reads the string constant \`report_schema_version/1\` from \`prolog/mutalog/report.pl\`, which \`report_dict/2\` writes as \`schemaVersion\`, and decides that it is "2".
