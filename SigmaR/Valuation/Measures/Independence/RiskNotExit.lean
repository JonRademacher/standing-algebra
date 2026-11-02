import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Risk Not Exit Viability
###############################################################################

Risk exposure does not license or imply exit viability.

Risk load captures exposure to harm or uncertainty.
Exit viability concerns the structural availability of
refusal or escape.

No default implication from risk exposure to exit viability
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating risk exposure as guaranteeing,
constituting, or licensing exit viability is permitted.
-/
axiom risk_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromRiskLoad a s
  )

end SigmaR.Valuation.Measures.Independence
