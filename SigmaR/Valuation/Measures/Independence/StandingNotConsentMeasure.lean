import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Standing (Measure) ≠ Consent
###############################################################################

Standing as a measure of recognition does not entail consent.

Consent is a voluntary act, not a consequence of standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing measures
to consent.
-/
axiom standing_not_consent_measure :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → ConsentState a s)

end SigmaR
