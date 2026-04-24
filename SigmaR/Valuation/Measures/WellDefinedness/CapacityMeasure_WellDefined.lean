import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity Measure Well-Definedness
###############################################################################

CapacityMeasure is total and distinct from standing.
###############################################################################
-/

namespace SigmaR

/--
Capacity measure is total.
-/
axiom CapacityMeasureTotal :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≥ 0

end SigmaR
