import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Risk Inheritance ≠ Capacity
###############################################################################

Inherited risk does not entail loss of capacity.

Capacity may persist despite inherited exposure, and
capacity may be constrained without inherited risk.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk inheritance
to capacity measures.
-/
axiom risk_inheritance_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       RiskInheritance a s → CapacityMeasure a s)

end SigmaR
