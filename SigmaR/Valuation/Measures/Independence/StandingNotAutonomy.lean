import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing ≠ Autonomy
###############################################################################
-/

namespace SigmaR

axiom StandingNotAutonomy :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ AutonomyMeasure a s

end SigmaR
