import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Risk Inheritance Not Standing
###############################################################################

Inherited risk does not entail standing.

Standing concerns recognition or admissible participation,
not exposure inherited through structure or history.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk inheritance
to standing.
-/
axiom risk_inheritance_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       RiskInheritance a s → StandingMeasure a s)

end SigmaR
