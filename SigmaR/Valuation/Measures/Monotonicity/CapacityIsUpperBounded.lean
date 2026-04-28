import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity Is Upper Bounded
###############################################################################

Agent capacity has finite upper limits.
###############################################################################
-/

namespace SigmaR

axiom capacity_upper_bounded :
  ∃ (B : Nat),
    ∀ (a : Agent) (s : State),
      CapacityMeasure a s ≤ B

end SigmaR
