import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Exit Collapse Not Consent
###############################################################################

Exit collapse does not license or imply the absence of consent.

Exit collapse concerns the unavailability of viable exit.
Consent is an agent-level act or expression that may occur
under constraint.

No default implication from exit collapse to consent
invalidation is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit collapse as negating,
invalidating, or licensing the absence of consent
is permitted.
-/
axiom exit_collapse_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentInvalidFromExitCollapse a s
  )

end SigmaR
