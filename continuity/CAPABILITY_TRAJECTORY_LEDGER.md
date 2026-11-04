# Capability Trajectory Ledger

| ID | Capability/operator | State | Evidence | Residual / next transition |
|---|---|---|---|---|
| CAP-001 | Reconstruct source repo identity and commits | tested | Standing repository remotes and CI receipts; read-only I2OS/NDGK audits | Standalone ICG/UCK unavailable; reopen on source access. |
| CAP-002 | Preserve attached source provenance | implemented | Corpus manifest and SHA-256 hashes | Revalidate after source files change. |
| CAP-003 | Build bounded context bundle | tested | Generated `CONTEXT_BUNDLE.md` at 17,974 characters against an 18,000-character limit; unit fixture checks the hard bound | Rebuild after source or checkpoint changes. |
| CAP-004 | Validate continuity graphs and checkpoint | validated | 35 Python tests, Markdown links, 1,076-file portable hash manifest, and release-mode validator passed locally | Hosted continuity workflow rerun remains pending. |
| CAP-005 | Learn reusable failure/discovery shapes | candidate | Initial examples in learning archive and Future Forensics taxonomy | Validate with further independent cases. |
| CAP-006 | Automatically improve agent model | not supported | No hidden state or background learning capability | Explicitly out of scope; only versioned repository deltas. |
| CAP-007 | Construct explicit model-inadequacy records | testable | Required record and procedure in `MODEL_INADEQUACY_CONSTRUCTOR.md` | Exercise against an observed reconstruction failure. |
| CAP-008 | Test candidate operators in isolation | testable | Synthetic fixture contract in `CAPABILITY_GYM/` | Add representative fixtures and verify canonical state remains untouched. |
| CAP-009 | Diagnose lost continuation paths | testable | Cause taxonomy and incident template in `FUTURE_FORENSICS.md` | Use an actual incident before claiming operational efficacy. |

Allowed lifecycle: `proposed -> testable -> tested -> corrected -> validated ->
operational -> superseded -> reopened`. A transition requires a dated evidence
record; skipping a state requires an explicit explanation. `reopened` retains
the superseded decision and records the new evidence that invalidated closure.
A proposed capability is never reported as demonstrated.
