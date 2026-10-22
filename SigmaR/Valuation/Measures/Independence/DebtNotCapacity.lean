import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StructrualDebt_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Structural Debt Not Capacity
###############################################################################

Structural debt tracks unresolved asymmetry or obligation.
Capacity measures agent-level ability or potential.

No default implication from structural debt to capacity
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating structural debt as constituting
or licensing capacity is permitted.
-/
axiom debt_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromStructuralDebt a s
  )

end SigmaR.Valuation.Measures.Independence
