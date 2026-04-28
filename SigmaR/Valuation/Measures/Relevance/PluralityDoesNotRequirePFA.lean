import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition

/-!
###############################################################################
# Plurality Does Not Require PFA
###############################################################################

Plurality exists independently of perceptual agreement.

Perceptual Frame Agreement may express or stabilize plurality,
but it does not generate it.
###############################################################################
-/

namespace SigmaR

/--
Plurality does not depend on PFA.
-/
axiom plurality_does_not_require_pfa :
  ∀ (G : Set Agent) (s : State),
    ¬ PFA G s ∨ True

end SigmaR
