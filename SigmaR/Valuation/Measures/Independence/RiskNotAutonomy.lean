import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Risk ≠ Autonomy
###############################################################################
-/

namespace SigmaR

axiom RiskNotAutonomy :
  ∀ (a : Agent) (s : State),
    RiskLoad a s ≠ AutonomyMeasure a s

end SigmaR
