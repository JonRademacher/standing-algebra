import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Capacity ≠ Debt
###############################################################################

Capacity reduction is not structural debt accumulation.
###############################################################################
-/

namespace SigmaR

axiom CapacityNotDebt :
  ∀ (a : Agent) (s : State),
    CapacityMeasure a s ≠ StructuralDebt a

end SigmaR
