import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Standing ≠ Consent (Measure Independence)
###############################################################################

Standing does not imply consent.
###############################################################################
-/

namespace SigmaR

/--
Standing does not entail consent.
-/
axiom StandingNotConsent :
  ¬ (∀ (i : Agent) (s : State),
      StandingMeasure i s > 0 → Consent i s)

end SigmaR
