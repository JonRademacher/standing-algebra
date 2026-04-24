import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Risk ≠ Exit
###############################################################################

Risk exposure is not equivalent to exit viability.
###############################################################################
-/

namespace SigmaR

axiom RiskNotExit :
  ∀ (a : Agent) (s : State),
    RiskLoad a s = 0 →
    ExitViable a ≠ False

end SigmaR
