import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity Measure Well-Definedness
###############################################################################

CapacityMeasure is total and distinct from standing.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
Capacity measure is total.
-/
axiom CapacityMeasureTotal :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≥ 0

end SigmaR.Valuation.Measures.WellDefinedness
