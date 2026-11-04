# Worked Continuity Examples

These are operational procedures, not claims that the sample scenario has
already occurred in every detail.

## 1. Resume an unfinished proof

Read the exact theorem file and source mapping, inspect current commit and
checkpoint, run the narrow build, identify the last accepted proof state, and
record unproved obligations. Continue without changing the theorem statement.
If blocked, preserve the error and reopen alternative tactics from the last
validated ancestor.

## 2. Reconcile a manuscript theorem with Lean

Record manuscript ID/page/statement and formal file/declaration. Compare
definitions, quantifiers, assumptions, and conclusion. If no one-to-one
mapping is established, mark it unresolved; do not infer that a similarly
named declaration proves the manuscript claim. Build validates only that
Lean declaration.

## 3. Preserve two surviving implementation paths

Enumerate both, state shared constraints, record elimination witnesses (none
if neither is eliminated), consequences and dependencies, and retain separate
trajectory IDs. An authorized user selects among survivors; the kernel does
not turn a recommendation into elimination.

## 4. Learn a CI failure shape

Capture commit, workflow/run, failed step, exact error, and affected files.
Localize the dependency, derive the minimal recurring pattern, compare with
existing failure records, test the correction on a second case, and record
residuals. A green rerun does not erase the failed attempt or prove unrelated
claims.

## 5. Validate and commit a process improvement

Write a proposal with trigger, old/new process, provenance, expected effects,
counterexamples, tests, rollback, and reopening. Run checks and regression
fixtures. Promote only after review and observed success; otherwise keep as a
candidate or reject with evidence. Update canonical state only after the
authorized repository change reaches its declared terminal state.

## 6. Reopen a closed decision

Retain the prior decision and checkpoint. Record new evidence and the exact
reopening condition it satisfies. Reconstruct changed dependencies, re-enumerate
survivors, and append a new decision; do not rewrite history or mark prior
evidence false unless it was independently invalidated.
