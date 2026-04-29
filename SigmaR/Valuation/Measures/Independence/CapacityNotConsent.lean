import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Capacity Not Consent
###############################################################################

Capacity expresses potential or ability.
Consent is an affirmative act.

No default implication from capacity measures to consent
is licensed. Any relationship must be introduced explicitly.
###############################################################################
-/

namespace SigmaR

/--
No implication treating capacity measures as implying
or licensing consent is permitted.
-/
axiom capacity_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromCapacityMeasure a s
  )

end SigmaR
