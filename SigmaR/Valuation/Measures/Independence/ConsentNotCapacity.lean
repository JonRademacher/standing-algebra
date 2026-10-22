import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Consent Not Capacity
###############################################################################

Consent is an affirmative act or expression.
Capacity measures agent-internal ability or potential.

No default implication from consent to capacity is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating consent as constituting
or licensing capacity is permitted.
-/
axiom consent_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromConsentState a s
  )

end SigmaR.Valuation.Measures.Independence
