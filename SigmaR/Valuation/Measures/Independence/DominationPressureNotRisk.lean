import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Domination Pressure ≠ Risk
###############################################################################

Domination pressure is a diagnostic collapse indicator.
Risk is inherited exposure.

They must not be definitionally conflated.
###############################################################################
-/

namespace SigmaR

axiom DominationPressureNotRisk :
  ∀ (s : State),
    DomPressure s ≠ RiskLoad

end SigmaR
