import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Risk Inheritance Not Capacity
###############################################################################

Inherited or structural risk does not license or imply
loss of capacity.

Risk inheritance tracks exposure transmitted through structure,
history, or dependency.
Capacity measures agent-level ability or potential.

No default implication from risk inheritance to capacity
loss is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk inheritance as eliminating,
revoking, or licensing the absence of capacity is permitted.
-/
axiom risk_inheritance_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityLostFromRiskInheritance a s
  )

end SigmaR
