import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Standing ≠ Risk
###############################################################################

Standing is not reducible to risk exposure.
An agent may bear risk without having standing changed,
and may have standing without significant risk exposure.
###############################################################################
-/

namespace SigmaR

axiom StandingNotRisk :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ RiskLoad a s

end SigmaR
