import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Risk Not Capacity
###############################################################################

This file establishes that risk exposure does not entail
loss of capacity.

Risk load measures inherited or situational exposure.
Capacity measures agent ability or potential.

An agent may face elevated risk while retaining capacity,
or lose capacity without increased risk.

Importing this file explicitly rejects any assumption that
risk exposure determines capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk load
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       RiskLoad a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- danger implies inability
- exposure substitutes for impairment
- capacity collapses into risk metrics

Risk and capacity are distinct structural dimensions.
-/
