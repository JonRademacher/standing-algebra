import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Exit Viability ≠ Domination Pressure
###############################################################################
-/

namespace SigmaR

axiom ExitNotDominationPressure :
  ∀ (a : Agent) (s : State),
    ExitViable a →
    DomPressure s ≠ 0

end SigmaR
