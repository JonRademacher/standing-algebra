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
