import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Exit ≠ Risk
###############################################################################
-/

namespace SigmaR

axiom ExitNotRisk :
  ∀ (a : Agent) (s : State),
    ExitViable a →
    RiskLoad a s ≠ 0

end SigmaR
