---
applyTo: "**/*.lean"
---
# Lean formalization requirements

- Preserve exact theorem statements, assumptions, and manuscript symbol meanings.
- Do not add `sorry`, weaken a theorem, or disguise an axiom as a proof.
- Map declarations to source theorem identifiers when a verified mapping exists.
- Distinguish axiomatic assumptions from derived theorems in documentation.
- Minimize imports without hiding dependencies.
- Record the exact toolchain, command, commit, and result for each build receipt.
- Compilation validates the encoded Lean statement, not source fidelity,
  mathematical originality, empirical adequacy, or external validity.
