import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ConsentState_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Consent ≠ Exit Viability
###############################################################################

Consented participation does not guarantee viable exit.
Consent may be structurally coerced due to dependency,
timing, or irreversibility.
###############################################################################
-/

namespace SigmaR

axiom ConsentNotExit :
  ∀ (a : Agent) (s : State),
    ConsentState a s →
    ExitViable a ≠ True

end SigmaR
