import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Consent
###############################################################################

Temporal accumulation does not license or imply the absence
or invalidation of consent.

Temporal accumulation reflects irreversible or narrowing
structural constraint across states.
Consent reflects voluntary participation at a given state.

No default implication from temporal accumulation to consent
invalidation is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating temporal accumulation as negating,
invalidating, or licensing the absence of consent
is permitted.
-/
axiom temporal_accumulation_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentInvalidFromTemporalAccumulation a s
  )

end SigmaR
