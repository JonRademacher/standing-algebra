import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Capacity Not Domination Pressure
###############################################################################

This file establishes that capacity measures do not entail
system-level domination pressure.

Capacity is an agent-level valuation expressing potential or ability.
Domination pressure is a global diagnostic of structural instability
and collapse.

Importing this file explicitly rejects any attempt to reduce
systemic domination to agent-level capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to domination pressure.
Any relationship between these quantities must be introduced explicitly.
-/
axiom capacity_not_domination_pressure :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → DominationPressure s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- individual ability aggregates into domination
- capacity loss predicts systemic collapse
- agent-level metrics can proxy structural instability

Capacity and domination pressure operate on different levels.
-/

