import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.StructrualDebt_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Capacity Not Debt
###############################################################################

Capacity expresses potential or ability.
Structural debt tracks accumulated, system-level constraint.

No default implication from capacity measures to
structural debt is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing assumptions of structural debt is permitted.
-/
axiom capacity_not_debt :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDebtFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
