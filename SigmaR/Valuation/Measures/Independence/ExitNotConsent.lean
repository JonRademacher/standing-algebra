import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Consent
###############################################################################

Exit viability does not license or imply consent.

Exit viability concerns the availability of non-coercive refusal
or escape.
Consent is an agent-level act or expression that may occur
under constraint.

No default implication from exit viability to consent
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit viability as constituting
or licensing consent is permitted.
-/
axiom exit_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromExitViable a s
  )

end SigmaR
