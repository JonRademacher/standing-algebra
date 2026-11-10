# Analytic binding obligations

The certificate interface is intentionally abstract. A complete Contract B implementation must construct `BoundedZeroCertificate T` from Mathlib's analytic objects.

## Required work

1. Prove the chosen `IsNontrivialZero` is equivalent to the repository's canonical RH predicate.
2. Use `riemannZeta` or the pole-corrected entire `completedRiemannZeta₀` as the analytic carrier.
3. Prove bounded zero finiteness. Relevant Mathlib modules include:
   - `Mathlib.Analysis.Analytic.IsolatedZeros`
   - `Mathlib.Analysis.Meromorphic.IsolatedZeros`
   - `Mathlib.Analysis.Meromorphic.Divisor`
   - `Mathlib.Analysis.Complex.CanonicalDecomposition`
4. Define multiplicity using `analyticOrderNatAt` or a compatible meromorphic/divisor API.
5. Prove certificate soundness and completeness.
6. Prove repeated multiset occurrences match analytic multiplicity exactly.
7. State boundary behavior for `|im ρ| = T`.
8. Produce a clean replay receipt before promoting any Lean theorem to verified.

## Mathematical residual

Even after the certificate construction is formalized, Contract B still requires equal counts for every positive height. That is equivalent to the unresolved RH burden, not an implementation detail.
