---
title: A crashing mutant is not retried past the limit
status: active
fact_kind: property_value
subject_key: scheduler.retry_a_mutant
property_key: retry_a_mutant_that_crashes_its_worker_on_a_fresh_worker_up_to_retries_times
operator: eq
value_type: bool
value_bool: false
origin:
  kind: agent
  recorded_at: '2026-11-02T11:32:05.544Z'
id: FACT-NEG-8FA9AE813FAC53CA
type: fact
---
The situation the failure-side scenario sets up for REQ-AUTO-8FA9AE813FAC53CA: the guarantee is put under attack, and the system must refuse or contain it.
