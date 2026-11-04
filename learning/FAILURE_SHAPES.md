# Failure Shapes

## FS-001 — Compilation success treated as source fidelity

### Triggering observation

Repository actions show successful compilation, while the repository README
states that the ICG transcription is partial and axioms remain assumptions.

### Epistemic status

Observation and source claim (README and Actions receipts).

### Minimal generating shape

Encoded statement compiles -> source correspondence unverified -> broad
formalization or validation claim.

### Scope and applicability

Lean, Coq, SMT-LIB, generated docs, release notes.

### Evidence and provenance

`README.md`; `.github/workflows/lean.yml`, `coq.yml`, `z3.yml`; Actions runs
listed in `manifests/CURRENT_CHECKPOINT.yaml`.

### Dependencies

Requires exact source statement and formal declaration mapping.

### Counterexamples and residuals

A different/weaker theorem may compile; model assumptions may remain axioms.

### Correction or reuse operator

Compare exact statement, assumptions, and dependencies with the authoritative
source before making source-fidelity claims.

### Validation performed

Remote computational checks passed; comprehensive theorem crosswalk absent.

### State delta

Added R-006/R-007 and explicit scope caveats to current state.

### Reopening or retirement conditions

Retire only after independently reviewed theorem map covers the claim.

## FS-002 — Repository label mistaken for source identity

### Triggering observation

Configured `I2OS-Structural-Admissibility` is not ICG; `Non-Domination-Governance-Kernel`
is not UCK.

### Epistemic status

Read-only repository audits; exact evidence in audit session reports.

### Minimal generating shape

Related naming/concept -> assumed identity -> wrong authority/dependency graph.

### Scope and applicability

Cross-repository ingestion and continuity initialization.

### Evidence and provenance

Repository list, remote identities, and read-only audits.

### Dependencies

Requires remote URL and actual source inventory.

### Counterexamples and residuals

Unconfigured or private repositories may exist outside the accessible account.

### Correction or reuse operator

Verify canonical URL, source contents, and commit before classifying a repo.

### Validation performed

Configured repositories and accessible GitHub user repos searched.

### State delta

Standalone ICG/UCK availability recorded as open residuals.

### Reopening or retirement conditions

User supplies canonical source URL/access or repository becomes available.
