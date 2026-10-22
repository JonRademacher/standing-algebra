import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Operations.ResolutionMethodDistinctness_Op

namespace SigmaR

/-- Cooperation does not increase structural dependency. -/
axiom DependencyNonIncreasing : Operation → Prop

/--
Operations-level invariant (Cooperation):

Cooperation does not increase dependency
or impose constraints on non-consenting agents.
-/
axiom CooperationInvariant :
  ∀ (F : Operation),
    CooperationOp F →
    Admissible F ∧ DependencyNonIncreasing F

/--
Derived theorem:

Cooperation preserves autonomy.
-/
theorem CooperationAutonomyPreserved
  (F : Operation)
  (hC : CooperationOp F) :
  Admissible F ∧ DependencyNonIncreasing F :=
by
  exact CooperationInvariant F hC

end SigmaR
