import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Tradeoff Justification
###############################################################################

The valuation system does not permit justification of harm
in one measure by improvement in another.
###############################################################################
-/

namespace SigmaR

/--
There is no general tradeoff justification across measures.
-/
axiom no_tradeoff_justification :
  ¬ (∀ (M₁ M₂ : Agent → State → Nat),
        ∀ (a : Agent) (s : State),
          True)

end SigmaR
