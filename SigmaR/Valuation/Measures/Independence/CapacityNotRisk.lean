import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Capacity Not Risk
###############################################################################

This file establishes that capacity measures do not entail risk load.

Capacity expresses potential or ability.
Risk load captures exposure to harm or uncertainty.
Risk may increase without reducing capacity, and capacity
may be constrained without increased risk.

Importing this file explicitly rejects any attempt to reduce
risk exposure to agent-level capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to risk load.
Any relationship between these quantities must be introduced explicitly.
-/
axiom capacity_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- reduced ability implies danger
- competence predicts risk exposure
- risk metrics can proxy functional capacity

Capacity and risk are orthogonal diagnostics.
-/
