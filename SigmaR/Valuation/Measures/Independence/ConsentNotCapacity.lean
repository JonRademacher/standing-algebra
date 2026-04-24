import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Consent ≠ Capacity (Measure Independence)
###############################################################################

Consent does not imply capacity or ability.
###############################################################################
-/

namespace SigmaR

/--
Consent is not definitionally reducible to capacity.
-/
axiom ConsentNotCapacity :
  ¬ (∀ (i : Agent) (s : State),
      Consent i s → CapacityMeasure i s > 0)

end SigmaR
