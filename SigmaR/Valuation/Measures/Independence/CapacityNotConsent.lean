import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing consent is permitted.
-/
axiom capacity_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
