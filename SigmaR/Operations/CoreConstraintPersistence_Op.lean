import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Core_Legitimacy.CoreConstraintPersistence_Justification

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
    CoreConstraintsSatisfied (composeOp G F)

/--
Derived theorem:

Core constraints are closed under operation sequencing.
-/
theorem CoreConstraintsClosedUnderComposition
  (F G : Operation)
  (hF : CoreConstraintsSatisfied F)
  (hG : CoreConstraintsSatisfied G) :
  CoreConstraintsSatisfied (composeOp G F) :=
by
  exact CoreConstraintInvariant F G hF hG

end SigmaR
