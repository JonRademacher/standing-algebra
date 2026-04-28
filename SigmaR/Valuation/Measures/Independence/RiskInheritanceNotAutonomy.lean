import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Risk Inheritance ≠ Autonomy
###############################################################################

Inherited or structural risk does not entail loss of autonomy.

An agent may inherit risk while retaining autonomy, and
autonomy may be constrained without inherited risk.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk inheritance
to autonomy measures.
-/
axiom risk_inheritance_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       RiskInheritance a s → AutonomyMeasure a s)

end SigmaR
