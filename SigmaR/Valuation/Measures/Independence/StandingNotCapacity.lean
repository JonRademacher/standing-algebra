import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Standing ≠ Capacity
###############################################################################

Standing and capacity are distinct valuation measures.
###############################################################################
-/

namespace SigmaR

axiom StandingNotCapacity :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ CapacityMeasure a s

end SigmaR
