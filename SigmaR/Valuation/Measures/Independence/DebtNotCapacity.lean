import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Debt ≠ Capacity
###############################################################################
-/

namespace SigmaR

axiom DebtNotCapacity :
  ∀ (a : Agent) (s : State),
    StructuralDebt a ≠ CapacityMeasure a s

end SigmaR
