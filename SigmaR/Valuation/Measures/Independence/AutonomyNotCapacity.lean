import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Autonomy ≠ Capacity
###############################################################################

Capacity expresses potential ability; autonomy expresses
freedom from coercive constraint. These are distinct.
###############################################################################
-/

namespace SigmaR

axiom AutonomyNotCapacity :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ CapacityMeasure a s

end SigmaR
