import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Risk
###############################################################################

Exit viability concerns the availability of refusal or escape.
Risk load captures exposure to harm or uncertainty.

No default implication from exit viability to risk exposure
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit viability as implying
or licensing risk exposure is permitted.
-/
axiom exit_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromExitViable a s
  )

end SigmaR
