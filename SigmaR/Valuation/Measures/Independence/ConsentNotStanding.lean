import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Consent Not Standing
###############################################################################

Consent is an affirmative act or expression.
Standing reflects recognized position, status, or inclusion.

No default implication from consent to standing is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as constituting
or licensing standing is permitted.
-/
axiom consent_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromConsentState a s
  )

end SigmaR
