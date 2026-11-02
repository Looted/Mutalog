---
title: The dry run times each test under coverage in a child process
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-dry-run-records-time-and-clauses
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: references
    files:
      - prolog/mutalog/client.pl
      - prolog/mutalog/coverage.pl
      - prolog/mutalog/run.pl
    extract: calls
  proves:
    - CLAIM-6C8166480553BF13
origin:
  kind: agent
  recorded_at: '2026-11-02T12:15:40.738Z'
id: TEST-cert-dry-run-runs-tests-under-coverage
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-d9089b9d122ff1aa446da5c4
    test_id: TEST-cert-dry-run-runs-tests-under-coverage
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: 8866414d7a7740071af402c3aa05f240737c101aeb51411e9680a2eaf9302691
    binding_hash: 8d7fb1225661f0683f65f040ea0266c4880a577744b7ceaa191592639c4244cb
    fingerprint: 50e5095aef94757895fa494b018aeb8212352d6ffc9d49768ea309c6b0c2c30f
    fingerprint_components:
      contract: 8866414d7a7740071af402c3aa05f240737c101aeb51411e9680a2eaf9302691
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
      - symbol_id: SYM-test-e2e-dry-run-records-time-and-clauses
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
      test_id: TEST-cert-dry-run-runs-tests-under-coverage
      source:
        reader: references
        files:
          - prolog/mutalog/client.pl
          - prolog/mutalog/coverage.pl
          - prolog/mutalog/run.pl
        extract: calls
      model:
        members:
          - '!/0'
          - $cov_data/3
          - $cov_reset/0
          - $cov_start/0
          - $cov_start/1
          - $cov_stop/0
          - $cov_stop/1
          - '=/2'
          - '=:=/2'
          - '==/2'
          - '>/2'
          - '>=/2'
          - \==/2
          - add_test_time/4
          - aggregate_all/3
          - append/3
          - asserta/1
          - at_end_of_stream/1
          - atom_string/2
          - atomic_list_concat/3
          - attempt/10
          - between/3
          - call_cleanup/3
          - catch/3
          - check_only/2
          - check_operators/1
          - clause_property/2
          - close/2
          - collect/4
          - collect_mutants/3
          - config_value/3
          - cov_reset/0
          - cov_start/1
          - cov_stop/1
          - coverage_index/3
          - covered_clauses/2
          - covering_tests/3
          - current_predicate/1
          - current_prolog_flag/2
          - directory_file_path/3
          - discover_files/4
          - domain_error/2
          - drop_ignored/3
          - drop_suppressed/2
          - exclude/3
          - fail/0
          - file_mutants/4
          - fill_buffer/1
          - findall/3
          - flush_output/1
          - foldl/4
          - forall/2
          - format/3
          - get_assoc/3
          - get_dict/3
          - get_time/1
          - group_pairs_by_key/2
          - hard_limit_margin/1
          - id_file_operator/3
          - ignored_mutant/2
          - include/3
          - is/2
          - job_cost/2
          - keysort/2
          - length/2
          - list_to_assoc/2
          - load_config/3
          - map_list_to_pairs/3
          - maplist/3
          - member/2
          - memberchk/2
          - message_queue_create/1
          - message_queue_destroy/1
          - mutalog_dry_run/3
          - mutalog_error/3
          - nb_getval/2
          - nb_setval/2
          - new_worker/2
          - nonvar/1
          - normalize_space/2
          - nth1/3
          - operator_names/1
          - option/2
          - option/3
          - pairs_values/2
          - parse_reply/2
          - percentage/3
          - plan_mutant/7
          - pool_loop/5
          - pool_size/3
          - pool_thread/3
          - print_message/2
          - process_create/3
          - process_kill/2
          - process_wait/2
          - process_wait/3
          - project_tests/3
          - prolog_load_context/2
          - read_pending_codes/3
          - read_reply/4
          - read_source/2
          - recycle/6
          - replace_worker/3
          - report_one/5
          - report_progress/4
          - report_uncovered/4
          - retryable/1
          - reverse/2
          - run_pool/5
          - run_test/2
          - run_tests/1
          - schedule/2
          - score_status/1
          - select_only/3
          - selected_mutant/2
          - set_stream/2
          - setup_call_cleanup/3
          - sort/2
          - sort/4
          - source_mutants/4
          - source_text/2
          - split_string/4
          - stale_ignore/4
          - start_worker/2
          - stop_current_worker/0
          - stop_pool/4
          - string_concat/3
          - sub_string/5
          - suppressed_mutant/2
          - suppression_comment/2
          - suppressions/2
          - term_string/2
          - test_exception/1
          - thread_create/3
          - thread_get_message/2
          - thread_join/2
          - thread_send_message/2
          - thread_signal/2
          - throw/1
          - to_atom/2
          - true/0
          - try_mutant/9
          - use_module/1
          - wait_for_input/3
          - warn_stale_ignores/4
          - worker_call/4
          - worker_file/1
          - worker_kill/1
          - worker_options/3
          - worker_start/3
          - worker_stop/1
          - write_term/3
    certificate_digest: 98e3c8d2e8cb9c65114961713bde0f93c0b60a57f39af01ce4a3ac8b7c932a4d
    claim_bindings:
      - claim_key: CLAIM-6C8166480553BF13
        requirement_id: REQ-AUTO-F7474BB290B90F77
        fact_id: FACT-PROP-030CEB64B5CCC1A8
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - $cov_data/3
            - get_time/1
            - process_create/3
            - run_tests/1
          operator: includes
---
Source proof for REQ-AUTO-F7474BB290B90F77. Kibi reads the calls of the client, the coverage module and the runner: the worker is a child process (`process_create/3`), and the dry run runs each test (`run_tests/1`) between timestamps (`get_time/1`) and reads the clauses it entered from the coverage data (`$cov_data/3`).

## Context

The proof run executes the end-to-end test `e2e:dry_run_records_time_and_clauses`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
