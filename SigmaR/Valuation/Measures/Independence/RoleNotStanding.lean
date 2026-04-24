import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RoleState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Role ≠ Standing
###############################################################################

Role occupancy or permission does not generate standing.
Standing is not conferred by institutional position.
###############################################################################
-/

namespace SigmaR

axiom RoleNotStanding :
  ∀ (a : Agent) (s : State),
    RoleState a s →
    StandingMeasure a s ≠ 0

end SigmaR
