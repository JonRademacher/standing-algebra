import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Risk Inheritance Not Standing
###############################################################################

Inherited or structural risk does not license or imply standing.

Standing concerns recognition or admissible participation.
Risk inheritance concerns exposure transmitted through structure,
history, or dependency.

No default implication from risk inheritance to standing
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk inheritance as constituting
or licensing standing is permitted.
-/
axiom risk_inheritance_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromRiskInheritance a s
  )

end SigmaR
