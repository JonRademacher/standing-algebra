import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity ≠ Autonomy
###############################################################################
-/

namespace SigmaR

axiom CapacityNotAutonomy :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ AutonomyMeasure a s

end SigmaR
