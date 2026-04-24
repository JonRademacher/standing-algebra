import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Risk ≠ Domination Pressure
###############################################################################

Risk exposure, even when elevated, does not itself
constitute domination pressure.
###############################################################################
-/

namespace SigmaR

axiom RiskNotDominationPressure :
  ∀ (s : State),
    RiskLoad ≠ DomPressure s

end SigmaR
