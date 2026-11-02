---
title: Mutant ids list file, line, column, operator and n in that order
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutant-ids-name-file-line-column-operator
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/generate.pl
    functor: mutant_id_field/1
  proves:
    - CLAIM-D222FF97845510F8
origin:
  kind: agent
  recorded_at: '2026-11-02T12:15:38.385Z'
id: TEST-cert-mutant-id-fields-in-order
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-815f2622bdfd9728a6f29009
    test_id: TEST-cert-mutant-id-fields-in-order
    scope: integration
    outcome: passed
    code_snapshot: f0def101d448e3aeaaffb3b4a42d3cf703322ae9e702c99227a2d5169142b1c4
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:26:20.515Z'
    finished_at: '2026-11-02T12:26:23.769Z'
    artifact_digest: 0eb21479dc3d0ace03b9f8a5215344914938124e5fa24ba44ce3e6a2a571298f
    contract_hash: 926c759bd838b2bc7359183c1755fa8288c1f91606ca6a657d183a886f7672f4
    binding_hash: 5dc416d07048a7266b81fdba7346867006d70e093b71bed9bea83620fdafb933
    fingerprint: 0676ed6a27d5e2e5b6a0fbf09fee5ca15be03a96c2b6eb52c8d12e2c4b9a11c3
    fingerprint_components:
      contract: 926c759bd838b2bc7359183c1755fa8288c1f91606ca6a657d183a886f7672f4
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
      - symbol_id: SYM-test-e2e-mutant-ids-name-file-line-column-operator
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: source
    evidence_level: proved
    certificate:
      version: kibi.code-certificate.v1
      kind: source
      test_id: TEST-cert-mutant-id-fields-in-order
      source:
        reader: prolog
        file: prolog/mutalog/generate.pl
        functor: mutant_id_field/1
      model:
        members:
          - column
          - file
          - line
          - 'n'
          - operator
        sequence:
          - file
          - line
          - column
          - operator
          - 'n'
    certificate_digest: 4dc0c2a2b150c4a67d37ad2500fc3bb311e0482ffc1818856bc335e31ef44d15
    claim_bindings:
      - claim_key: CLAIM-D222FF97845510F8
        requirement_id: REQ-AUTO-B2BB75D2FD157B91
        fact_id: FACT-PROP-A2A7ED4347AB1F25
        binding: derived
        scope: source
        obligation:
          kind: sequence_precedes
          members:
            - column -> operator
            - file -> line
            - line -> column
            - operator -> n
---
Source proof for REQ-AUTO-B2BB75D2FD157B91. Kibi reads the `mutant_id_field/1` facts of `prolog/mutalog/generate.pl` in file order; `assign_id/5` joins those fields with colons to build every id.

## Context

The proof run executes the end-to-end test `e2e:mutant_ids_name_file_line_column_operator`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
