---
title: Workers start as child processes
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-crash-is-isolated-in-a-worker-process
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: references
    files:
      - prolog/mutalog/client.pl
      - prolog/mutalog/run.pl
    extract: calls
  proves:
    - CLAIM-31AEF4005052471E
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:42.343Z'
id: TEST-cert-workers-are-child-processes
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-77125e84aafed28938850e47
    test_id: TEST-cert-workers-are-child-processes
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: 23b79ffb86827ea3c3c767b8b4d51547a3867f9576406af5b3e02ea5ca183ca5
    binding_hash: f3a240d693a502712035dbd3a90d24550e5889abefbb0a72231a9423e52bc6eb
    fingerprint: 4ec5a82e3d1a4536f9ed8d2c3f7fe5a2822378bc101396b5ce3e3ca34a32f38a
    fingerprint_components:
      contract: 23b79ffb86827ea3c3c767b8b4d51547a3867f9576406af5b3e02ea5ca183ca5
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
      - symbol_id: SYM-test-e2e-crash-is-isolated-in-a-worker-process
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
      test_id: TEST-cert-workers-are-child-processes
      source:
        reader: references
        files:
          - prolog/mutalog/client.pl
          - prolog/mutalog/run.pl
        extract: calls
      model:
        members:
          - '!/0'
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
          - close/2
          - collect/4
          - collect_mutants/3
          - config_value/3
          - coverage_index/3
          - covering_tests/3
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
          - schedule/2
          - score_status/1
          - select_only/3
          - selected_mutant/2
          - set_stream/2
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
    certificate_digest: b9b5be89c04c830bdd403526ab829592c4698d7e168ddf3b23d677fb9e0aeaed
    claim_bindings:
      - claim_key: CLAIM-31AEF4005052471E
        requirement_id: REQ-AUTO-43894D6940BD6965
        fact_id: FACT-PROP-3538AD07C01339E4
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - process_create/3
          operator: includes
---
Source proof for REQ-AUTO-43894D6940BD6965. Kibi reads `prolog/mutalog/client.pl` and `run.pl` and checks they start workers with `process_create/3`.

## Context

The proof run executes the end-to-end test `e2e:crash_is_isolated_in_a_worker_process`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
