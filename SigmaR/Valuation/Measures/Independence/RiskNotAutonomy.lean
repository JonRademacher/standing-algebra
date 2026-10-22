import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Risk Not Autonomy
###############################################################################

Risk exposure does not license or imply loss of autonomy.

Risk load captures exposure to harm or uncertainty.
Autonomy measures freedom from coercive constraint.

No default implication from risk exposure to autonomy
loss is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating risk exposure as eliminating,
revoking, or licensing the absence of autonomy is permitted.
-/
axiom risk_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyLostFromRiskLoad a s
  )

end SigmaR.Valuation.Measures.Independence
