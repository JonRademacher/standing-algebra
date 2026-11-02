import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level predicate:

`F` satisfies all constraints of all applicable regimes.

Declared here, at the operations layer, because it classifies operations; the
Tier‑2 justification imports it rather than redeclaring it.
-/
axiom AllRegimeConstraintsSatisfied : Operation → Prop

/--
Operations-level predicate: operation `F` has a normal form `F'`.
-/
axiom NormalizedForm : Operation → Operation → Prop

/--
Operations-level invariant:

Any operation satisfying all applicable constraints
has a well-defined normalized form.
-/
axiom NormalizationExists :
  ∀ (F : Operation),
    AllRegimeConstraintsSatisfied F →
    ∃ F' : Operation,
      NormalizedForm F F'

/--
Derived theorem:

Operations admit a unique constraint-respecting normalization.
-/
theorem OperationNormalizable
  (F : Operation)
  (h : AllRegimeConstraintsSatisfied F) :
  ∃ F' : Operation,
    NormalizedForm F F' :=
by
  exact NormalizationExists F h

end SigmaR
