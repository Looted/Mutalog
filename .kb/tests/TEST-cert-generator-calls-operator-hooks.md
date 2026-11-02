---
title: The operators module calls the multifile hooks
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-custom-operator-from-a-project
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: references
    files:
      - prolog/mutalog/operators.pl
      - prolog/mutalog/run.pl
    extract: calls
  proves:
    - CLAIM-52A2B13D36667257
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:37.630Z'
id: TEST-cert-generator-calls-operator-hooks
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-2588a391142a9d0976b61cf4
    test_id: TEST-cert-generator-calls-operator-hooks
    scope: integration
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: bfe2285bd9336776b82aa7d7be41df63e11d33688a3c5606f7b69ae7315a9355
    binding_hash: 08b9fae38cbc43097d950cab62d6ef390d61d1f9d855e4a06b0bc18eec323879
    fingerprint: 2d0ee9cdedfde677c773862c248815487caa549f328832b8b03e9c37a0b0468d
    fingerprint_components:
      contract: bfe2285bd9336776b82aa7d7be41df63e11d33688a3c5606f7b69ae7315a9355
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
      - symbol_id: SYM-test-e2e-custom-operator-from-a-project
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
      test_id: TEST-cert-generator-calls-operator-hooks
      source:
        reader: references
        files:
          - prolog/mutalog/operators.pl
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
          - \=/2
          - \==/2
          - \=@=/2
          - add_test_time/4
          - aggregate_all/3
          - append/3
          - arith_swap/2
          - atom_string/2
          - atomic_list_concat/3
          - attempt/10
          - between/3
          - call_cleanup/3
          - catch/3
          - check_only/2
          - check_operators/1
          - collect/4
          - collect_mutants/3
          - compare_swap/2
          - compound/1
          - compound_name_arguments/3
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
          - findall/3
          - float/1
          - foldl/4
          - forall/2
          - format/3
          - get_assoc/3
          - get_dict/3
          - get_time/1
          - group_pairs_by_key/2
          - id_file_operator/3
          - ignored_mutant/2
          - include/3
          - integer/1
          - is/2
          - job_cost/2
          - keysort/2
          - length/2
          - list_to_assoc/2
          - literal_swap/2
          - load_config/3
          - map_list_to_pairs/3
          - maplist/3
          - member/2
          - memberchk/2
          - memberchk_eq/2
          - message_queue_create/1
          - message_queue_destroy/1
          - mutalog:mutate/4
          - mutalog:operator/2
          - mutalog_dry_run/3
          - mutalog_error/3
          - nb_getval/2
          - nb_setval/2
          - new_worker/2
          - normalize_space/2
          - nth1/3
          - operator_names/1
          - pairs_values/2
          - percentage/3
          - plan_mutant/7
          - pool_loop/5
          - pool_size/3
          - pool_thread/3
          - print_message/2
          - project_tests/3
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
          - sort/2
          - sort/4
          - source_mutants/4
          - source_text/2
          - split_string/4
          - stale_ignore/4
          - start_worker/2
          - stop_current_worker/0
          - stop_pool/4
          - string/1
          - string_concat/3
          - sub_string/5
          - suppressed_mutant/2
          - suppression_comment/2
          - suppressions/2
          - thread_create/3
          - thread_get_message/2
          - thread_join/2
          - thread_send_message/2
          - thread_signal/2
          - throw/1
          - to_atom/2
          - true/0
          - try_mutant/9
          - unify_swap/2
          - use_module/1
          - warn_stale_ignores/4
          - worker_call/4
          - worker_options/3
          - worker_start/3
          - worker_stop/1
    certificate_digest: 2ced48a3d4ac52dacf922bb82216e8a0cc50889e41e4d00ed50de09f8659b700
    claim_bindings:
      - claim_key: CLAIM-52A2B13D36667257
        requirement_id: REQ-AUTO-211A7AC532ADA588
        fact_id: FACT-PROP-0ADBE2F36E784C3D
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - mutalog:mutate/4
            - mutalog:operator/2
          operator: includes
---
Source proof for REQ-AUTO-211A7AC532ADA588. Kibi reads `prolog/mutalog/operators.pl` and `run.pl` term by term and checks they call `mutalog:operator/2` and `mutalog:mutate/4`, the multifile hooks a project adds clauses to.

## Context

The proof run executes the end-to-end test `e2e:custom_operator_from_a_project`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
