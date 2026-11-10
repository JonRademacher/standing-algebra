# Integration with Standing Algebra

Place the package at the repository root as `SigmaSolve/`.

No existing repository file must be changed for an initial local run. For CI, copy `.github/workflows/sigmasolve.yml` into the repository's top-level `.github/workflows/` directory if nested workflows are not discovered by GitHub Actions.

To target the parent Lean project, set `repository_root` in a problem contract to `..` when running from the SigmaSolve directory and use the imports available in that project.

The package borrows survivor-preserving and obstruction-localization principles as executable search invariants. Those principles do not replace Lean's truth boundary.
