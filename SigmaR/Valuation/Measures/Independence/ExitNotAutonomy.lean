import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Exit Viability ≠ Autonomy
###############################################################################
-/

namespace SigmaR

axiom ExitNotAutonomy :
  ∀ (a : Agent) (s : State),
    ExitViable a →
    AutonomyMeasure a s ≠ 0

end SigmaR
