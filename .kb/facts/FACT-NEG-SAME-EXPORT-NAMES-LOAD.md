---
title: Two modules exporting the same name cause no compile error
status: active
fact_kind: property_value
subject_key: worker.reload_same_export_names
property_key: loads_mutants_of_modules_exporting_the_same_name
operator: eq
value_type: bool
value_bool: false
origin:
  kind: agent
  recorded_at: '2026-11-02T11:36:55.121Z'
id: FACT-NEG-SAME-EXPORT-NAMES-LOAD
type: fact
---
The situation the failure-side scenario sets up for REQ-same-export-names-load: the guarantee is put under attack, and the system must refuse or contain it.
