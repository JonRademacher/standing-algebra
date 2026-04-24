import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level invariant:

All operations preserve core constraints under composition.
This is a structural fact, not a legitimacy judgment.
-/
axiom CoreConstraintInvariant :
  ∀ (F G : Operation),
    CoreConstraintsSatisfied F →
    CoreConstraintsSatisfied G →
    CoreConstraintsSatisfied (G ∘ F)

/--
Derived theorem:

Core constraints are closed under operation sequencing.
-/
theorem CoreConstraintsClosedUnderComposition
  (F G : Operation)
  (hF : CoreConstraintsSatisfied F)
  (hG : CoreConstraintsSatisfied G) :
  CoreConstraintsSatisfied (G ∘ F) :=
by
  exact CoreConstraintInvariant F G hF hG

end SigmaR
