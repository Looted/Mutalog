---
title: The pack requires only SWI-Prolog 9.0 or later
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-pack-needs-only-swi-prolog
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: pack.pl
    functor: requires/1
  proves:
    - CLAIM-F41496DB7B7BFFCA
origin:
  kind: agent
  recorded_at: '2026-11-02T14:28:40.589Z'
id: TEST-cert-pack-requires-only-swi-prolog-9
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-abd0dd80f66a7ebf262bfc69
    test_id: TEST-cert-pack-requires-only-swi-prolog-9
    scope: integration
    outcome: passed
    code_snapshot: 7badf2b44de46828539bb0c7499deaba2c21dac1e52f09a5a7deb9310f9f1d2e
    environment_hash: 70794eb189f6bb0bd59b638fedca584356a0b61f01329f6f9f4e9f53a3b5be53
    started_at: '2026-11-02T14:33:10.932Z'
    finished_at: '2026-11-02T14:33:22.700Z'
    artifact_digest: 568f4e88a5b468a962c6ab7c478ada7d6380cf10d6be8ff979724e2d1dce69aa
    contract_hash: 0ea85ea86df1931b8f803940d27c1b6a2c783f57d19bff81ba479b7e49fc986c
    binding_hash: bdad03c457d9b3fecbcb992a4e38229ea5ca967374eb50191b44faa7107e56e4
    fingerprint: 804e6e868e8dbfb2a3f23dcb5ae73a149f99833b9eaf79ad7eeba3443c996732
    fingerprint_components:
      contract: 0ea85ea86df1931b8f803940d27c1b6a2c783f57d19bff81ba479b7e49fc986c
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
      - symbol_id: SYM-test-e2e-pack-needs-only-swi-prolog
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
      test_id: TEST-cert-pack-requires-only-swi-prolog-9
      source:
        reader: prolog
        file: pack.pl
        functor: requires/1
      model:
        members:
          - prolog>='9.0.0'
        sequence:
          - prolog>='9.0.0'
    certificate_digest: 9c01dc4053c4fc8922ace48b74a3839d721e5a09a9d7c17f0382a925fbd651a3
    claim_bindings:
      - claim_key: CLAIM-F41496DB7B7BFFCA
        requirement_id: REQ-AUTO-674E6097A8013135
        fact_id: FACT-PROP-3684404D80072C40
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - prolog>='9.0.0'
          operator: eq
---
Source proof for REQ-AUTO-674E6097A8013135. Kibi reads the \`requires/1\` facts of \`pack.pl\`: the only requirement is \`prolog >= 9.0.0\`, so \`pack_install\` needs nothing outside the SWI-Prolog distribution.

## Context

The proof run executes the end-to-end test `e2e:pack_needs_only_swi_prolog`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
