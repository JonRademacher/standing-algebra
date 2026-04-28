import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing Is Upper Bounded
###############################################################################

Standing is finite and saturates within a system.
###############################################################################
-/

namespace SigmaR

axiom standing_upper_bounded :
  ∃ (B : Nat),
    ∀ (a : Agent) (s : State),
      StandingMeasure a s ≤ B

end SigmaR
