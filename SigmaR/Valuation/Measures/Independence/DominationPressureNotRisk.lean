import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Domination Pressure Not Risk
###############################################################################

Domination pressure is a system-level diagnostic of structural
instability or collapse.
Risk load captures inherited or situational exposure to harm.

No default implication from domination pressure to risk
exposure is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating domination pressure as implying
or licensing risk exposure is permitted.
-/
axiom domination_pressure_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromDominationPressure a s
  )

end SigmaR
