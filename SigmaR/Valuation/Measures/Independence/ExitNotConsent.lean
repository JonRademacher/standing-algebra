import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ConsentState_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Exit Viability ≠ Consent
###############################################################################

Viable exit does not imply that participation
was consented or uncoerced.
###############################################################################
-/

namespace SigmaR

axiom ExitNotConsent :
  ∀ (a : Agent) (s : State),
    ExitViable a →
    ConsentState a s ≠ True

end SigmaR
