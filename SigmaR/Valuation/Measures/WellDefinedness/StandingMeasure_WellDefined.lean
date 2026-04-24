import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing Measure Well-Definedness
###############################################################################

StandingMeasure is total and well-defined
for all agents and states.
###############################################################################
-/

namespace SigmaR

/--
Standing measure is total.
-/
axiom StandingMeasureTotal :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≥ 0

end SigmaR
