---
applyTo: "**/*.v"
---
# Coq formalization requirements

- Do not introduce `Admitted` in promoted work; list inherited admits as open
  residuals with exact paths and theorem names.
- Record theorem-to-source mapping, assumptions, universes, and dependencies.
- Preserve the source statement rather than weakening it to obtain compilation.
- Include reproducible Coq version and build commands in validation receipts.
- A successful `coqc` run does not establish source fidelity or external review.
