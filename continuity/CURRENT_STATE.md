# Current Canonical State

**Checkpoint ID:** `UCK-2026-11-04-001` (initialized integration checkpoint)
**Checkpoint date:** 2026-11-04
**Product status:** the continuity integration and cross-platform hash
correction are committed and pushed. The corrected Continuity Integrity
workflow passed; the checkpoint is being regenerated to include that receipt.
The unrelated pre-existing Lean edit remains uncommitted.

**Repository revisions:**

- standing-algebra: `cbc4211baf0993d643e55398addabf9588120f3f` (observed
  `origin/main`; main-branch Lean, Coq, and Z3 workflows passed).
- ICG: `cbc4211baf0993d643e55398addabf9588120f3f` for the integrated
  `ICG/` subtree only; a distinct ICG repository was not located.
- kernel integration host: `bd3f0703ad3f9a65de9e50a920d08e693c0fb956`
  (`jonrademacher-complete-lean4-formalizations`; corrective commit is pushed
  and its Continuity Integrity workflow passed).

## Canonical versions

- Standing Algebra: repository README and `SigmaR/`; paper source snapshot
  v6.6 is preserved in `corpus/standing-algebra/`.
- ICG: distinct formalization at `ICG/` and `ICG.lean`; manuscript snapshot in
  `corpus/icg/`. The README explicitly documents partial source coverage.
- Operational kernel integration: version `0.1.0`, defined in `kernel/` and
  `continuity/`; it is not represented as the full UCK v3.55.

## Active objectives

- Maintain reconstructable continuity across sessions from versioned evidence.
- Turn failures and discoveries into transparent, tested, reversible
  repository improvements.
- Preserve Σᴿ and ICG source identity and all unresolved source gaps.

## Validated invariants

- Σᴿ and ICG are separate frameworks; the ICG README calls out partial
  formalization coverage.
- At the observed commits, Standing Algebra Lean, Coq, and Z3 GitHub Actions
  checks passed. This is compilation/solver verification, not mathematical
  source fidelity or external validation.
- The prior Goodhart workflow-control prototype has 22 passing Python tests
  as reported by its executed test run; it is a separate prototype, not proof
  of self-improvement effectiveness.

## Active trajectories

- `AT-001`: build and validate this continuity integration; initialize
  checkpoint and bounded context bundle.
- `AT-002`: locate and ingest the standalone ICG source repository if the user
  supplies its canonical URL or makes it accessible.
- `AT-003`: ingest complete UCK v3.55 and continuity source materials when
  supplied; currently only attached text/package material is available.

## Open residuals

See `OPEN_RESIDUALS.md`. Key residuals: standalone ICG/UCK repositories absent;
full UCK corpus documents listed in the specification are not available in
this workspace; source-to-formalization theorem mapping is not comprehensive;
integration CI is newly initialized and only local checks are observed until
the new GitHub workflow runs.

## Known conflicts

- Product specification requests three repositories; only Standing Algebra,
  I2OS Structural Admissibility, and Non-Domination Governance Kernel are
  configured. The latter two are not ICG/UCK sources.
- Prior source manuscripts make broad formalization/validation claims; the
  repository README explicitly limits ICG coverage and states that axioms
  remain model assumptions. The narrower repository statements govern this
  checkpoint.
- The current worktree had an unrelated user edit in
  `Collapse_Demonstrations/collapse.lean`; it is preserved and excluded from
  this product delta.

## Current nondominated checkpoints

- `UCK-2026-11-04-001`: canonical partial checkpoint of the initialized
  continuity integration working tree, with explicit missing-source
  residuals and passing local integrity checks. Integration files are not yet
  committed or pushed.
- Standing Algebra GitHub Actions on main commit `cbc4211b`: Lean, Coq, and
  Z3 all passed; receipts are listed in `manifests/CURRENT_CHECKPOINT.yaml`.

## Superseded states retained for provenance

- Prior worktree commit `1fb47f313b1ddb147ed1ac3506a06f4f12fa43cf` introduced
  the Goodhart workflow control prototype and was merged into main by
  `cbc4211b`.
- Earlier Lean repair commit `1309de3f5fd69127929e23d6d6e19cb5bd9dc3b4`
  repaired merge damage; it remains in ancestry.

## Current proof and CI status

- Standing Algebra main: Lean / Coq / Z3 Actions succeeded at the source commit
  stated above; local Lean independence guard was previously blocked by WSL,
  so the CI receipt is the authoritative run evidence.
- ICG: shares the Standing Algebra source repository's Lean build. Build
  success does not imply complete transcription; see ICG README coverage
  boundary.
- Integration: 35 standard-library Python tests pass after adding regression
  coverage for portable hashing. The initial hosted continuity workflow failed
  at hash verification on commit `a464e447`; the failure and correction are
  archived in `learning/`. Corrected hosted run 41891627641 passed on
  `bd3f0703`.

## Reopening conditions

Reopen source identity if the canonical ICG repository URL is supplied or
found; reopen UCK scope when primary source documents or repository become
available; reopen any validation claim when commit, workflow receipt, source
mapping, or test evidence changes.

## Next admissible executable steps

1. Review the generated integration paths and preserve the unrelated
   `Collapse_Demonstrations/collapse.lean` edit.
2. Commit only the requested integration paths after authorizing a commit;
   then regenerate the checkpoint and record the commit receipt.
3. Push this branch only after user instruction; request/perform no silent
   merge or release.
