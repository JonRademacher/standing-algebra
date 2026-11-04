# Reentry Index

| Situation | Start here | Recovery path |
|---|---|---|
| New session | `CURRENT_STATE.md` then current checkpoint | Verify exact branch/HEAD and residuals before using summaries. |
| Lean/Coq/Z3 failure | relevant workflow, CI receipt, changed files, failure archive | Localize earliest error; preserve last green commit; retry narrow check. |
| Source/repo mismatch | `PROJECT_GRAPH.md`, corpus manifest | Reopen source identity; do not infer from names. |
| Missing theorem mapping | residual R-006 | Locate manuscript identifier and formal declaration; add evidence-backed mapping. |
| Candidate improvement | `CHANGE_PROTOCOL.md`, experiment log | Keep candidate noncanonical until tests, review, rollback and provenance exist. |
| No admissible candidates | candidate landscape and failure shape | Localize constraints/pathway and return to nearest validated ancestor. |
| Suspected stale state | hashes, repository commits, timestamp | Recompute and mark stale; do not silently overwrite prior checkpoint. |
| Resume prior decision | decision log and reopening condition | Preserve old decision; append evidence and reopen state. |
