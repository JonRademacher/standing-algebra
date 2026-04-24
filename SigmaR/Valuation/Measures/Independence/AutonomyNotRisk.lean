import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Autonomy ≠ Risk
###############################################################################

An agent may bear risk without autonomy loss,
and may suffer autonomy loss without elevated risk.
###############################################################################
-/

namespace SigmaR

axiom AutonomyNotRisk :
  ∀ (a : Agent) (s : State),
    AutonomyMeasure a s ≠ RiskLoad a s

end SigmaR
