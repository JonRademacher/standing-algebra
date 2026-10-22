import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Standing Not Risk
###############################################################################

Standing does not license or imply risk exposure.

Standing measures recognized status or admissible participation.
Risk load captures exposure to harm or uncertainty.

No default implication from standing to risk exposure
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as constituting,
determining, or licensing risk exposure is permitted.
-/
axiom standing_not_risk :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRiskFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
