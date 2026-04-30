import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Standing Not Consent
###############################################################################

Standing does not license or imply consent.

Standing measures recognized status or admissible participation
within a system.
Consent is an agent-level condition of voluntary agreement.

No default implication from standing to consent
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as constituting,
generating, or licensing consent is permitted.
-/
axiom standing_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromStandingMeasure a s
  )

end SigmaR
