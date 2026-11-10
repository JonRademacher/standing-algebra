# SigmaSolve RH Contracts A+B

Repository-ready additive package for `SigmaSolve/research/rh-contracts-ab/`.

## Contract A: exact predicate binding

Contract A binds the abstract bounded-to-global bridge to an explicit zeta predicate:

- `IsZetaZero ρ := riemannZeta ρ = 0`
- `IsNontrivialZero ρ := IsZetaZero ρ ∧ 0 < ρ.re ∧ ρ.re < 1`
- `OnCriticalLine ρ := ρ.re = 1/2`

The chosen nontrivial-zero definition is deliberately isolated in one file. Review it against the repository's preferred RH definition before promotion. The abstract bridge itself does not depend on that choice.

## Contract B: bounded certificate realization

Contract B separates:

1. the finite multiset count theorem, which is elementary;
2. a certificate interface with soundness and completeness obligations;
3. the analytic construction of an exact bounded zeta-zero multiset, which remains open pending Mathlib binding and actual Lean verification.

## Install into the repository

Extract this ZIP into:

```text
standing-algebra/SigmaSolve/research/rh-contracts-ab/
```

The package is additive and does not overwrite existing SigmaSolve files.

## Validation

Python tests and exhaustive finite-model checks are included. Lean source is drafted but was not kernel-checked in the generation host because Lean/Lake were unavailable.

Run:

```bash
python -m pytest -q tests
lake env lean lean/SigmaSolve/RH/BoundedGlobalBridge.lean
lake env lean lean/SigmaSolve/RH/ZetaPredicateBinding.lean
lake env lean lean/SigmaSolve/RH/CountGeometry.lean
lake env lean lean/SigmaSolve/RH/CertificateInterface.lean
```

## Rerun correction

The initial package predicate `re != 0 and re != 1` was too weak and did not exclude trivial zeros. The rerun uses the critical-strip predicate `riemannZeta rho = 0 and 0 < re rho and re rho < 1`.
