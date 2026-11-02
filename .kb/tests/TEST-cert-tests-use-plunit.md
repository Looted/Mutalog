---
title: The project's tests are plunit tests
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-mutates-itself
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: references
    files:
      - prolog/mutalog.pl
      - prolog/mutalog/discover.pl
      - test/run.pl
      - test/test_e2e.plt
      - test/test_mutalog.plt
    extract: imports
  proves:
    - CLAIM-D7ECBE437ACD3ED5
origin:
  kind: agent
  recorded_at: '2026-11-02T12:15:43.113Z'
id: TEST-cert-tests-use-plunit
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-c94f0d11a07b9543ef2fd594
    test_id: TEST-cert-tests-use-plunit
    scope: integration
    outcome: passed
    code_snapshot: c28f5f3868c52cbb35d19153b7e33583599a32c8b77ee042f9c753d4925a6c34
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T12:20:49.704Z'
    finished_at: '2026-11-02T12:21:34.788Z'
    artifact_digest: 04011dfac1062759f1cefc50cc1535749d7ef6539e9cf5855cf4c642e072e905
    contract_hash: 7d221ce42ce58411c67138992adbad3a1dfeb42fe85e88aea6948f50f90e4bad
    binding_hash: c8ebd65b946a159f930865e2aaca7ba515e80259b784812ea4a89289d12aa768
    fingerprint: 58cafb18da119b49c3a266758b52e7a4249e1cf3475e8b41f3e35eaee1c2f4ff
    fingerprint_components:
      contract: 7d221ce42ce58411c67138992adbad3a1dfeb42fe85e88aea6948f50f90e4bad
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
      - symbol_id: SYM-test-e2e-mutates-itself
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
      test_id: TEST-cert-tests-use-plunit
      source:
        reader: references
        files:
          - prolog/mutalog.pl
          - prolog/mutalog/discover.pl
          - test/run.pl
          - test/test_e2e.plt
          - test/test_mutalog.plt
        extract: imports
      model:
        members:
          - ../prolog/mutalog
          - ../prolog/mutalog/config
          - ../prolog/mutalog/discover
          - ../prolog/mutalog/generate
          - ../prolog/mutalog/operators
          - ../prolog/mutalog/reader
          - ../prolog/mutalog/report
          - ../prolog/mutalog/run
          - library(aggregate)
          - library(apply)
          - library(debug)
          - library(error)
          - library(filesex)
          - library(http/json)
          - library(lists)
          - library(plunit)
          - library(process)
          - library(readutil)
          - library(yall)
          - mutalog/config
          - mutalog/discover
          - mutalog/generate
          - mutalog/operators
          - mutalog/reader
          - mutalog/report
          - mutalog/run
          - test_e2e.plt
          - test_mutalog.plt
    certificate_digest: ba30f3e9d5bc0f20f757e42eb61dacf8a68cb5470c087a6a51cfebe96343f9dd
    claim_bindings:
      - claim_key: CLAIM-D7ECBE437ACD3ED5
        requirement_id: REQ-AUTO-4CF26847DCD17B68
        fact_id: FACT-PROP-6C8F5ED9528BFB37
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - library(plunit)
          operator: includes
---
Source proof for REQ-AUTO-4CF26847DCD17B68. Kibi reads what the test files load: they import `library(plunit)`, so `mutalog run` can run them against mutants of Mutalog itself.

## Context

The proof run executes the end-to-end test `e2e:mutates_itself`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
