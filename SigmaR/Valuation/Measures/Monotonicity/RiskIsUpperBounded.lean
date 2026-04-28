import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Risk Is Upper Bounded
###############################################################################

Risk exposure is bounded in any admissible system.
###############################################################################
-/

namespace SigmaR

axiom risk_upper_bounded :
  ∃ (B : Nat),
    ∀ (a : Agent) (s : State),
      RiskLoad a s ≤ B

end SigmaR
