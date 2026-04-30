import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Standing (Measure) Not Consent
###############################################################################

Standing as a measure of recognition does not license or imply consent.

Standing measures recognized status or admissible participation.
Consent is a voluntary agent-level act, not a consequence of standing.

No default implication from standing measures to consent
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing measures as constituting,
generating, or licensing consent is permitted.
-/
axiom standing_not_consent_measure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromStandingMeasure a s
  )

end SigmaR
