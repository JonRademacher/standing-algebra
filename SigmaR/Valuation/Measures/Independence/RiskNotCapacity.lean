import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Risk Not Capacity
###############################################################################

Risk exposure does not license or imply loss of capacity.

Risk load captures inherited or situational exposure.
Capacity measures agent-level ability or potential.

No default implication from risk exposure to capacity
loss is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating risk exposure as eliminating,
revoking, or licensing the absence of capacity is permitted.
-/
axiom risk_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityLostFromRiskLoad a s
  )

end SigmaR.Valuation.Measures.Independence
