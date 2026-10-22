import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

/-!
###############################################################################
# Standing Measure Well-Definedness
###############################################################################

StandingMeasure is total and well-defined
for all agents and states.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
Standing measure is total.
-/
axiom StandingMeasureTotal :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s ≥ 0

end SigmaR.Valuation.Measures.WellDefinedness
