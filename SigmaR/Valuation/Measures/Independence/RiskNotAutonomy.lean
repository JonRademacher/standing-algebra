import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

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

namespace SigmaR

/--
No implication treating risk exposure as eliminating,
revoking, or licensing the absence of autonomy is permitted.
-/
axiom risk_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyLostFromRiskLoad a s
  )

end SigmaR
