# Decision Log

## DEC-2026-11-04-001 — Host continuity integration in Standing Algebra

- **Status:** accepted for this initialization; scope-limited.
- **Observation:** accessible projects include Standing Algebra, I2OS
  Structural Admissibility, and Non-Domination Governance Kernel. Audit found
  neither I2OS nor NDGK to be the requested ICG/UCK repository. GitHub account
  listing also showed no standalone ICG/UCK repo.
- **Candidate paths:** (A) create new repo; (B) add to NDGK; (C) add
  continuity/product layer to Standing Algebra while keeping `SigmaR/` and
  `ICG/` distinct and documenting missing peer repos.
- **Disposition:** C is the nearest available authorized path. Creating a
  repository requires separate explicit user confirmation; NDGK's own
  continuity policy discourages broad expansion without review.
- **Provenance:** user build package; repository inventory; read-only audits of
  `i2os-lab/I2OS-Structural-Admissibility` and
  `JonRademacher/Non-Domination-Governance-Kernel`.
- **Residual:** standalone ICG and UCK source repositories remain unavailable.
- **Reopen when:** user supplies their canonical URLs or access.

## DEC-2026-11-04-002 — Treat CI green as computational verification only

- **Status:** accepted.
- **Evidence:** remote Lean, Coq, and Z3 Actions succeeded at the observed
  Standing Algebra main commit.
- **Rule:** do not infer faithful manuscript transcription, originality,
  independent reproduction, or external validation from those runs.
- **Reopen when:** theorem mappings or independent scholarly review are added.

## DEC-2026-11-04-003 — Preserve uncommitted collapse edit

- **Status:** accepted.
- **Observation:** `Collapse_Demonstrations/collapse.lean` is modified in the
  workspace and predates this integration task.
- **Decision:** preserve and exclude it from generated hashes/checkpoint claims
  and any staging or commit.
- **Reopen when:** user explicitly requests its review or inclusion.
