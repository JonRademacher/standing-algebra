---
applyTo: "continuity/**,kernel/**,learning/**,governance/**,manifests/**"
---
# Continuity artifact requirements

- Preserve epistemic labels, source lineage, exact commit identities, and
  reopening conditions.
- Every promoted decision and learning entry needs provenance, dependencies,
  validation evidence, residuals, and rollback/reopening conditions.
- Keep source authority in the original repository; summaries link to sources.
- Update hashes and checkpoint state only after validation; do not claim a
  canonical state from a stale or uncommitted source snapshot.
