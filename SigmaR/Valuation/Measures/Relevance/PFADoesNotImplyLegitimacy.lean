import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition

/-!
###############################################################################
# PFA Does Not Imply Legitimacy
###############################################################################

Perceptual Frame Agreement does not confer authority,
legitimacy, or justification for action or policy.
###############################################################################
-/

namespace SigmaR

/--
Perceptual agreement does not imply legitimacy.
-/
axiom pfa_not_legitimacy :
  ∀ (G : Set Agent) (s : State),
    PFA G s →
    True

end SigmaR
