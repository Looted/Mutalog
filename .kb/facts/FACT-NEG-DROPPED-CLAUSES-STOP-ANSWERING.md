---
title: A dropped clause cannot answer for the mutant
status: active
fact_kind: property_value
subject_key: worker.drop_stale_clauses
property_key: dropped_clauses_stop_answering_after_reload
operator: eq
value_type: bool
value_bool: false
origin:
  kind: agent
  recorded_at: '2026-11-02T11:36:20.526Z'
id: FACT-NEG-DROPPED-CLAUSES-STOP-ANSWERING
type: fact
---
The situation the failure-side scenario sets up for REQ-dropped-clauses-stop-answering: the guarantee is put under attack, and the system must refuse or contain it.
