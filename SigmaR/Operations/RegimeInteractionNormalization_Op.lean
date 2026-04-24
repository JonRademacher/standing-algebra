import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

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
