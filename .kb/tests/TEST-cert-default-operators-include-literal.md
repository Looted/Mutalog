---
title: The default operators include literal
status: active
verification_scope: integration
verification_perspective: internal
proof_contract:
  version: kibi.proof-contract.v1
  integration: unit
  required_proofs:
    - symbol_id: SYM-test-e2e-operator-literal
      target: default
  success_policy: all_required_first_attempt
  kind: source
  source:
    reader: prolog
    file: prolog/mutalog/config.pl
    functor: default_operators/1
  proves:
    - CLAIM-ACB47111EB4C4DE9
origin:
  kind: agent
  recorded_at: '2026-11-02T11:28:32.413Z'
id: TEST-cert-default-operators-include-literal
type: test
proof_receipts:
  - version: kibi.proof-receipt.v2
    receipt_id: PR-f5bf76add2a6225b808e6107
    test_id: TEST-cert-default-operators-include-literal
    scope: integration
    outcome: passed
    code_snapshot: 2063fb4323db87cf5b095b08855dab50e6840ec188855ef6e88e038254065d01
    environment_hash: 0fe4faff3abd9383846f773ccd03a2e551c0e1792023b3084ed58b8687bccfaa
    started_at: '2026-11-16T18:02:12.920Z'
    finished_at: '2026-11-16T18:02:53.381Z'
    artifact_digest: c6940f38f909a978dbf4eccfc6524315eddb2667d6dff77a7fadefb452eb9855
    contract_hash: 4817c6ced94c8967a68a9ae4a9611b92457a420e3847ce8d15a42f5bafc80797
    binding_hash: 62628d1c75825dc7fa521f437ad1f4efacd30cfcb908c437fa5f885269e0ccea
    fingerprint: 197156da388c43b12ddfcbf270bf5266ea8d1e966aa8382281453dc2a65fcacd
    fingerprint_components:
      contract: 4817c6ced94c8967a68a9ae4a9611b92457a420e3847ce8d15a42f5bafc80797
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
      - symbol_id: SYM-test-e2e-operator-literal
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
      test_id: TEST-cert-default-operators-include-literal
      source:
        reader: prolog
        file: prolog/mutalog/config.pl
        functor: default_operators/1
      model:
        members:
          - arith
          - clause_drop
          - compare
          - cut
          - cut_insert
          - goal_fail
          - goal_true
          - literal
          - negate
          - unify
        sequence:
          - arith
          - compare
          - unify
          - negate
          - cut
          - cut_insert
          - goal_true
          - goal_fail
          - clause_drop
          - literal
    certificate_digest: 97524fbc354bfa281dfbfbf0d4622188ed6c22060129f66fe7a3db038294e651
    claim_bindings:
      - claim_key: CLAIM-ACB47111EB4C4DE9
        requirement_id: REQ-AUTO-A3B9E1922440A581
        fact_id: FACT-PROP-AE158B3F363D2C78
        binding: derived
        scope: source
        obligation:
          kind: set_relation
          members:
            - literal
          operator: includes
---
Source proof for REQ-AUTO-A3B9E1922440A581. Kibi reads the list in `default_operators/1` in `prolog/mutalog/config.pl` and checks it includes `literal`, so the operator runs without any configuration.

## Context

The proof run executes the end-to-end test `e2e:operator_literal`, which shows the behaviour; Kibi reads the code itself at ingest and decides the claim from what it reads.
