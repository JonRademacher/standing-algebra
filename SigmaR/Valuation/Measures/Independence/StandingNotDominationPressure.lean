import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing ≠ Domination Pressure
###############################################################################
-/

namespace SigmaR

axiom StandingNotDominationPressure :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≠ DomPressure s

end SigmaR
