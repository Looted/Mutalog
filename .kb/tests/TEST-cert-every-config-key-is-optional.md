---
title: Every configuration key is optional
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-proof-config-keys
      target: default
  success_policy: all_required_first_attempt
  kind: exhaustive
  domain_source:
    symbol_id: SYM-config-default-setting
    arg: 1
    export: default_setting/2
  proves:
    - CLAIM-7E601561E9998F9C
origin:
  kind: agent
  recorded_at: '2026-11-02T12:15:33.586Z'
id: TEST-cert-every-config-key-is-optional
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-c3a437f0219cc24d5b0d6c0e
    test_id: TEST-cert-every-config-key-is-optional
    scope: integration
    outcome: passed
    code_snapshot: f0def101d448e3aeaaffb3b4a42d3cf703322ae9e702c99227a2d5169142b1c4
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:26:20.515Z'
    finished_at: '2026-11-02T12:26:23.769Z'
    artifact_digest: 0eb21479dc3d0ace03b9f8a5215344914938124e5fa24ba44ce3e6a2a571298f
    contract_hash: ee6ee8fe3aeebbd0a6038d99e10ef5312ad12bf6ffecd693695f44d7f87d7bed
    binding_hash: c6ad195b4d333e9f3e23c7ab86e355a88c10862c070bdeb492ff23595cb3bb78
    fingerprint: 82230c399bec2102ae21aba5d20a7be3bb6938b0735e28ec7f87d7103990fcba
    fingerprint_components:
      contract: ee6ee8fe3aeebbd0a6038d99e10ef5312ad12bf6ffecd693695f44d7f87d7bed
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
      - symbol_id: SYM-proof-config-keys
        target: default
        outcome: passed
        binding: aggregate_run
        attempts:
          status: unavailable
    kind: exhaustive
    evidence_level: proved
    certificate:
      domain:
        members:
          - root
          - mutate
          - ignore
          - tests
          - load
          - operators
          - ignore_mutants
          - concurrency
          - timeout_ms
          - timeout_factor
          - retries
          - worker_reuse
          - stack_limit
          - thresholds
          - reporters
          - report_dir
        symbol_id: SYM-config-default-setting
      kind: exhaustive
      results:
        - member: root
          outcome: passed
        - member: mutate
          outcome: passed
        - member: ignore
          outcome: passed
        - member: tests
          outcome: passed
        - member: load
          outcome: passed
        - member: operators
          outcome: passed
        - member: ignore_mutants
          outcome: passed
        - member: concurrency
          outcome: passed
        - member: timeout_ms
          outcome: passed
        - member: timeout_factor
          outcome: passed
        - member: retries
          outcome: passed
        - member: worker_reuse
          outcome: passed
        - member: stack_limit
          outcome: passed
        - member: thresholds
          outcome: passed
        - member: reporters
          outcome: passed
        - member: report_dir
          outcome: passed
      test_id: TEST-cert-every-config-key-is-optional
      version: kibi.code-certificate.v1
    certificate_digest: fcf5abff378a77c8e04701685f2b496535e6f7ccdf7fe4275a2043df667602ac
    claim_bindings:
      - claim_key: CLAIM-7E601561E9998F9C
        requirement_id: REQ-AUTO-CE1F43687FF92977
        fact_id: FACT-PROP-B60F579E6B8AFE38
        binding: derived
        scope: code
        obligation:
          kind: set_equals
          members:
            - concurrency
            - ignore
            - ignore_mutants
            - load
            - mutate
            - operators
            - report_dir
            - reporters
            - retries
            - root
            - stack_limit
            - tests
            - thresholds
            - timeout_factor
            - timeout_ms
            - worker_reuse
---
Exhaustive proof for REQ-AUTO-CE1F43687FF92977. Kibi loads `prolog/mutalog/config.pl` and reads every key from `default_setting/2`; the proof run loads the configuration of a project with no config file and certifies that each of those keys still has a value. The set of keys must be exactly the fact's set.
