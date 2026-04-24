import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity ≠ Standing
###############################################################################
-/

namespace SigmaR

axiom CapacityNotStanding :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ StandingMeasure a s

end SigmaR
