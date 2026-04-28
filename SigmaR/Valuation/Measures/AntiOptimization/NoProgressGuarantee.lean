import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Progress Guarantee
###############################################################################

The valuation system does not assume progress,
advancement, or improvement over state progression.
###############################################################################
-/

namespace SigmaR

/--
There is no guarantee of progress across states.
-/
axiom no_progress_guarantee :
  ¬ (∀ (a : Agent) (s₁ s₂ : State),
        True)

end SigmaR
