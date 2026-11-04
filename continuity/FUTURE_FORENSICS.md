# Future Forensics

Use this investigation when a previously viable, explicitly identified
continuation is no longer reachable. This classifies a failure path; it does
not claim the lost path was uniquely correct or that all futures can be
enumerated.

## Cause taxonomy

Select every cause supported by evidence; leave uncertain causes open.

| Code | Cause | Diagnostic question |
|---|---|---|
| FF-01 | Missing capability | Was a required operation unavailable or not implemented? |
| FF-02 | Missing or inaccessible carrier | Was required state absent, unreadable, or not transferred? |
| FF-03 | Failed retrieval | Did lookup fail despite an available source? |
| FF-04 | Faulty reconstruction | Was retrieved evidence misread, merged, or misattributed? |
| FF-05 | Stale currentness | Was a previously valid state used after its source changed? |
| FF-06 | Applicability mismatch | Was a valid rule applied outside its declared scope? |
| FF-07 | Authority obstruction | Was an action blocked by missing authorization or a conflicting authority boundary? |
| FF-08 | Unrecognized dependency | Did an undiscovered prerequisite make the path infeasible? |
| FF-09 | Capability not recruited | Was an available operator not selected or invoked? |
| FF-10 | Execution failure | Did the selected operation fail at runtime or in a proof/build tool? |
| FF-11 | False completion | Was success reported without the required terminal receipt? |
| FF-12 | Hidden winner-selection rule | Did an undeclared selector eliminate a still-admissible path? |

## Incident template

```yaml
id: FF-YYYY-MM-DD-NNN
candidate_path: Stable trajectory or task identifier
last_verified_checkpoint: Checkpoint ID and source revision
expected_terminal_state: Explicit observable condition
observed_state: Exact failure, receipt, or missing artifact
cause_codes: []
evidence: []
alternative_causes: []
reconstruction_confidence: low
recovery_options: []
regression_test: []
disposition: candidate
```

Record the failing run and its exact output before attempting recovery. Separate
what was observed from causal interpretation. Test a proposed correction on a
bounded regression fixture, retain the failed trace, and update the
failure-shape archive only when the pattern is reproducible or independently
corroborated.
