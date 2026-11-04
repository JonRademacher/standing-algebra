# Open Residuals

| ID | Status | Description | Reopening / closure evidence |
|---|---|---|---|
| R-001 | open | No standalone ICG repository is accessible. ICG source currently resides under `ICG/` in Standing Algebra; no separate repo identity can be asserted. | User supplies canonical repository URL/access; audit repository and revisions. |
| R-002 | open | No standalone Unified Compatibility Kernel repository or complete UCK corpus is available. The integration uses the attached build package and prior Copilot continuity notes only. | User supplies repository or named primary materials; audit provenance and version. |
| R-003 | open | Additional transfer docs listed by the build package are not in the current session's available source files. | Ingest each supplied document with provenance and hash. |
| R-004 | open | NDGK workspace audit exact HEAD and live CI status could not be directly confirmed; merge-base only was observed. It is not treated as authoritative UCK state. | Read-only access provides exact HEAD and workflow receipts. |
| R-005 | open | I2OS repository has internal author inconsistency (README citation vs paper title page/bib) and no validation/CI receipt in the audit. It is excluded from product authority. | Repository maintainers reconcile attribution and publish validated evidence. |
| R-006 | open | Comprehensive manuscript theorem-ID-to-formalization mapping for Σᴿ/ICG was not found. | Create and review a crosswalk against authoritative source documents. |
| R-007 | open | ICG README reports selected formalization and source gaps; successful aggregate build does not close these. | Per-source theorem inventory and verified formalization mapping. |
| R-008 | open | Root branch contains pre-existing uncommitted `Collapse_Demonstrations/collapse.lean` change. | User resolves or authorizes separate handling; preserve meanwhile. |
| R-009 | open | The continuity product is pushed, but the latest hosted workflow must pass after the hash portability correction. | Inspect successful Continuity Integrity receipt on the corrected commit. |
| R-010 | open | Checkpoint `UCK-2026-11-04-001` predates the integration commit and must be regenerated to identify the committed product revision and current residuals. | Regenerate and validate the checkpoint after the corrective commit and remote workflow receipt. |
| R-011 | open | Current scripts validate artifact integrity and references, not mathematical semantics, source transcription, product efficacy, or scholarly validity. | Add domain-appropriate independent reviews and source crosswalks. |
| R-012 | open | Copilot customization files are repository artifacts; not all Copilot clients may support every agent/skill/prompt surface. No live Copilot configuration test was performed. | Test in each target Copilot host/version and record receipts. |
| R-013 | open | Initial hosted hash verification failed because `.git` worktree metadata was included and extensionless UTF-8 files were not normalized across operating-system checkouts. | Portable hashing correction passes the hosted integrity workflow on the corrective commit. |
