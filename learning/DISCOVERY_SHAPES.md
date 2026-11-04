# Discovery Shapes

## DS-001 — Separate source authority from integration host

### Triggering observation

The specification calls for a third integration repository, but no standalone
UCK repo is accessible and available peer projects are not UCK/ICG.

### Epistemic status

Repository inventory observation and bounded reconstruction.

### Minimal generating shape

Missing preferred host -> verify alternatives -> preserve source distinctions
in the nearest authorized existing host -> record missing repository as residual.

### Scope and applicability

Repository-backed integrations when a proposed central repository is absent.

### Evidence and provenance

Configured repo inventory, `gh repo list`, read-only audits, user build package.

### Dependencies

Requires source identities and permission to add a new repository.

### Counterexamples and residuals

A dedicated integration repository may be a better long-term topology.

### Correction or reuse operator

Use an existing host only as an explicit fallback; keep peer nodes, sources,
and residuals distinct.

### Validation performed

Repository identity audits; product tests to be recorded in checkpoint.

### State delta

Decision DEC-001; project graph and current state identify the hosting choice.

### Reopening or retirement conditions

Dedicated UCK repo becomes available or user authorizes creation of one.

## DS-002 — Make integrity receipts portable across Git checkouts

### Triggering observation

The first hosted Continuity Integrity run on the committed integration passed
tests and links but found a non-portable hash manifest.

### Epistemic status

Observed remote failure; local corrective regression tests passed, with hosted
verification pending.

### Minimal generating shape

Exclude host-specific `.git` metadata, identify UTF-8 text by content rather
than extension, normalize CRLF only for that text, and preserve byte-exact
hashing for binary data.

### Scope and applicability

Integrity manifests generated on one operating system and checked on another.

### Evidence and provenance

Action run 41890985104; `Tests/test_continuity_tools.py` portable-hash fixtures.

### Dependencies

Depends on distinction between Git checkout representation and binary payload
identity.

### Counterexamples and residuals

Hosted CI must pass on the corrected commit; SHA-256 integrity does not prove
authorship or source correctness.

### Correction or reuse operator

Use NUL-free valid UTF-8 detection for newline canonicalization and retain raw
bytes for binary files.

### Validation performed

Local tests pass; remote receipt pending.

### State delta

Update the hash helper, regression tests, and failure-shape archive.

### Reopening or retirement conditions

Reopen if any cross-platform hash mismatch recurs.
