---
title: The reader reads source with SWI-Prolog's reader
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-reads-custom-operators-and-syntax
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: references
    files:
      - prolog/mutalog/reader.pl
    extract: calls
  proves:
    - CLAIM-F21D845A55939F81
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:40.039Z'
id: TEST-cert-reader-uses-swi-prolog-reader
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-ca3e348443c48312912a1f8d
    test_id: TEST-cert-reader-uses-swi-prolog-reader
    scope: integration
    outcome: passed
    code_snapshot: 92e3954df4f617ded2727621938b06fd4e05ade1fa7b70daf347fa96818d6d78
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T11:39:41.926Z'
    finished_at: '2026-11-02T11:40:29.375Z'
    artifact_digest: 7d01fd058c5eddf0d483e1e7fec068a609ce5e15ae1c3d99860885d6a7727ec2
    contract_hash: e21b59a1805b059c192586ab1ea55093d00b872c5b7032d4532ffd2ae02cc101
    binding_hash: 499f577d2123ed153f9927480d937c0ea43c6646738366e580473e231e1ec11b
    fingerprint: de5c2b31d2baf19c5d9ff6a560a152c28e3e875d8a91937331ebf29814ddab64
    fingerprint_components:
      contract: e21b59a1805b059c192586ab1ea55093d00b872c5b7032d4532ffd2ae02cc101
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
      - symbol_id: SYM-test-e2e-reads-custom-operators-and-syntax
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
      test_id: TEST-cert-reader-uses-swi-prolog-reader
      source:
        reader: references
        files:
          - prolog/mutalog/reader.pl
        extract: calls
      model:
        members:
          - '!/0'
          - $current_source_module/1
          - </2
          - '=/2'
          - '=</2'
          - '==/2'
          - arg/3
          - chr_rule/1
          - classify/4
          - clause_kind/2
          - compound/1
          - compound_name_arity/3
          - copy_term_nat/2
          - current_op/3
          - directive/2
          - findall/3
          - forall/2
          - full_stop_after/3
          - gensym/2
          - is/2
          - last_start/6
          - line_starts/2
          - memberchk/2
          - nth0/3
          - op/3
          - op_class/2
          - prolog_close_source/1
          - prolog_open_source/2
          - prolog_read_source_term/4
          - read_clauses/5
          - read_file_to_string/3
          - set_stream/2
          - setup_call_cleanup/3
          - snapshot_ops/1
          - string_codes/2
          - string_length/2
          - sub_string/5
          - term_range/4
          - test_block_state/3
          - use_module/1
          - var/1
    certificate_digest: 69e7be8e5ef8b5042d9b39f1f7924da012e4b0f150c9a260d73fe1efef2f8920
    claim_bindings:
      - claim_key: CLAIM-F21D845A55939F81
        requirement_id: REQ-AUTO-408D5C7AFB1C4E71
        fact_id: FACT-PROP-E2648E718B904DFA
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - prolog_read_source_term/4
          operator: includes
---
Source proof for REQ-AUTO-408D5C7AFB1C4E71. Kibi reads `prolog/mutalog/reader.pl` and checks it calls `prolog_read_source_term/4`, SWI-Prolog's own source reader.

## Context

The proof run executes the end-to-end test `e2e:reads_custom_operators_and_syntax`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
