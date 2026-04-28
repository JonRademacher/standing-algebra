import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Domination Pressure Not Capacity
###############################################################################

This file establishes that domination pressure does not entail
loss of agent-level capacity.

Capacity measures agent ability or potential.
Domination pressure measures system-level instability or
approach to structural collapse.

Importing this file explicitly rejects any assumption that
systemic collapse diagnostics substitute for agent capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from domination pressure
to loss of capacity.
Any relationship between these concepts must be introduced explicitly.
-/
axiom domination_pressure_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       DominationPressure s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- systemic instability implies individual incapacity
- collapse diagnostics can proxy ability
- agent capacity collapses into system-level pressure

Domination pressure and capacity operate at different levels.
-/

