import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Consent Not Capacity
###############################################################################

Consent is an affirmative act or expression.
Capacity measures agent-internal ability or potential.

No default implication from consent to capacity is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as constituting
or licensing capacity is permitted.
-/
axiom consent_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromConsentState a s
  )

end SigmaR
