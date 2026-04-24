import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level predicate:

`F` represents a cooperation operation
where agents jointly act without imposing
constraints on non-participants.
-/
constant CooperationOp : Operation → Prop

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
