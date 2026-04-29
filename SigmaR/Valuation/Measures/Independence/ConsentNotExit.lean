import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Consent Not Exit Viability
###############################################################################

Consent does not license or guarantee exit viability.
Exit viability is a structural condition concerning refusal,
non-coercion, and the availability of escape.

No default implication from consent to exit viability is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as guaranteeing
or licensing exit viability is permitted.
-/
axiom consent_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromConsentState a s
  )

end SigmaR

