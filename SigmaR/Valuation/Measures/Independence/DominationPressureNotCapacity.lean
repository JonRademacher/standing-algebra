import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Domination Pressure Not Capacity
###############################################################################

Domination pressure is a system-level diagnostic of structural
instability and collapse.
Capacity measures agent-level ability or potential.

No default implication from domination pressure to loss
or absence of capacity is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating domination pressure as eliminating,
revoking, or licensing the absence of agent capacity
is permitted.
-/
axiom domination_pressure_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityLostFromDominationPressure a s
  )

end SigmaR.Valuation.Measures.Independence
