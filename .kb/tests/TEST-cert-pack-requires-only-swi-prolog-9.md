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
    receipt_id: PR-ff6e560e295a566937156edc
    test_id: TEST-cert-pack-requires-only-swi-prolog-9
    scope: integration
    outcome: passed
    code_snapshot: 4438def34e66ffe8937d68d0c5f0887183e35451bf5083911dda87a8daffdd59
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:06:32.394Z'
    finished_at: '2026-11-16T18:07:14.325Z'
    artifact_digest: 3992beee0ca4fb3672ae8309ca8ee97cb67d7776525624fa7ea9b9fd9d514bb0
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
