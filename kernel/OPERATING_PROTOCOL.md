# Operating Protocol

1. Reconstruct the verified worktree, canonical state, current checkpoint,
   sources, dependencies, and open residuals.
2. Declare the objective, constraints, and materially viable candidate paths.
3. Preserve all survivors; eliminate only with a recorded witness.
4. Localize failure to its pathway and return to the nearest validated,
   nondominated ancestor when recovery is needed.
5. Propose a repository delta with source, provenance, dependencies, evidence,
   counterexamples, expected effects, risks, tests, rollback, and reopening.
6. Validate without silently weakening source statements or requirements.
7. Promote only after observed validation; update state, learning records,
   hashes, residuals, and receipts.
8. Report exact terminal states and unresolved items.

The protocol governs observable repository operations. It does not describe
hidden model state, autonomous background work, or an identity transfer.
