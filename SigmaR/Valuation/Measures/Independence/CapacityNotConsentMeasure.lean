import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Capacity (Measure) Not Consent
###############################################################################

Capacity as ability or potential does not license or imply consent.
Any relationship between capacity measures and consent must be
introduced explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating capacity measures as implying
or licensing consent is permitted.
-/
axiom capacity_not_consent_measure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromCapacityMeasure a s
  )

end SigmaR
