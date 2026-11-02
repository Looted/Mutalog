---
title: The pack is named mutalog
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-installs-as-a-pack
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: pack.pl
    functor: name/1
  proves:
    - CLAIM-6CB5F995D76A1CAD
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:46.817Z'
id: TEST-cert-pack-is-named-mutalog
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-5c17eb46cb1752a0210fccc1
    test_id: TEST-cert-pack-is-named-mutalog
    scope: integration
    outcome: passed
    code_snapshot: 9b748336e039d27e7e0ff9bee18315be621d81372bd9d40f1eb50b3040793111
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:28:48.365Z'
    finished_at: '2026-11-02T14:29:12.598Z'
    artifact_digest: 37b6c4d9ca0c4dad9fe9a44b86be2656e30d22de5754e82316bb41392f547c18
    contract_hash: f4c69d886909e9c39b976faf8ed7971179d7f041c1afd0a05f883e472816f385
    binding_hash: fd0f1a9650b3b96241620d5c6b6fd836189d6917e027ce83f61bcb7f098538b0
    fingerprint: 90039339084f6ba4ea50fbeb679b9e7577bee6644bc30f5087886499b8dd037f
    fingerprint_components:
      contract: f4c69d886909e9c39b976faf8ed7971179d7f041c1afd0a05f883e472816f385
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
      - symbol_id: SYM-test-e2e-installs-as-a-pack
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
      test_id: TEST-cert-pack-is-named-mutalog
      source:
        reader: prolog
        file: pack.pl
        functor: name/1
      model:
        members:
          - mutalog
        sequence:
          - mutalog
    certificate_digest: f6be0301b4b2478908c29723d62496a625a22777e4d7c1c1c8f7fc448dae5de3
    claim_bindings:
      - claim_key: CLAIM-6CB5F995D76A1CAD
        requirement_id: REQ-AUTO-957337CBB4A00275
        fact_id: FACT-PROP-BF2A5C7C27317FAE
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - mutalog
          operator: eq
---
Source proof for REQ-AUTO-957337CBB4A00275. Kibi reads the `name/1` fact of `pack.pl` and checks it is `mutalog`, the name `pack_install(mutalog)` looks up.

## Context

The proof run executes the end-to-end test `e2e:installs_as_a_pack`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
