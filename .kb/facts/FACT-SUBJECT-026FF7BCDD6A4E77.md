---
title: Run Imported Module Mutants
status: active
text_ref: mcp://kibi/model-requirement
tags:
  - strict-modeling
  - confidence:0.80
  - confidence-band:medium
  - provenance:mcp-kibi-model-requirement
  - lane:strict
  - fact:subject
  - vocabulary:new-subject
fact_kind: subject
subject_key: run.imported_module_mutants
canonical_key: run.imported_module_mutants
claim_key: CLAIM-5E35237EA8AC7184
claim_text: Every mutant of a module that another loaded module imports must load.
origin:
  kind: agent
  recorded_at: '2026-11-02T11:37:32.859Z'
id: FACT-SUBJECT-026FF7BCDD6A4E77
type: fact
---
The mutants of a mutated file that is a module imported by another module of the project under test. Loading such a mutant must keep the importing module's view of the exports intact. Narrower than worker.reload, which covers reloading any mutated file; distinct from worker.reload_same_export_names, which is about two mutated modules exporting one name.