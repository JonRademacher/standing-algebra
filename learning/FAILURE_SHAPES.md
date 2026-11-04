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

## FS-003 — Hashing checkout representation instead of stable text content

### Triggering observation

The continuity workflow passed its unit and link steps, then failed the hash
step on GitHub Actions. Its manifest included the worktree `.git` pointer and
reported mismatches for extensionless UTF-8 files and empty `.keep` files
checked out with different line-ending behavior.

### Epistemic status

Observed GitHub Actions failure on commit `a464e447a780692755ce5cf8c9f8548200892490`;
the correction passed hosted validation on commit
`bd3f0703ad3f9a65de9e50a920d08e693c0fb956`.

### Minimal generating shape

Hash local worktree bytes and classify text by a narrow extension allowlist ->
include host-specific Git metadata and miss extensionless text normalization ->
cross-platform CI hash mismatch.

### Scope and applicability

Cross-platform integrity manifests over a Git worktree, especially files with
CRLF checkout conversion, extensionless text, and `.git` pointer files.

### Evidence and provenance

GitHub Actions run 41890985104 failed at “Verify corpus and repository hashes”;
the failed log named `.git`, `_CoqProject`, `lean-toolchain`, and `.keep` paths.

### Dependencies

Depends on `managed_files`, `sha256_file`, and a consistent definition of
tracked content independent of host checkout metadata.

### Counterexamples and residuals

Binary content must retain byte-exact hashing; arbitrary binary bytes cannot
be newline-normalized.

### Correction or reuse operator

Exclude the `.git` pointer; normalize CRLF only for NUL-free valid UTF-8 text,
including extensionless files, and hash other files byte-for-byte.

### Validation performed

35 local Python tests passed. GitHub Actions run 41891627641 passed continuity
tests, Markdown links, cross-platform SHA-256 verification, and release-mode
checkpoint validation on the corrective commit.

### State delta

Portable hash normalization and exclusion fixtures added.

### Reopening or retirement conditions

Retire if another cross-platform hash mismatch demonstrates a remaining case.
