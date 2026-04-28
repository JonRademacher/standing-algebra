import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition

/-!
###############################################################################
# PFA Does Not Imply Truth
###############################################################################

Perceptual Frame Agreement reflects consistency of honest
perception, not correctness or objective truth.
###############################################################################
-/

namespace SigmaR

/--
Perceptual agreement does not entail truth.
-/
axiom pfa_not_truth :
  ∀ (G : Set Agent) (s : State),
    PFA G s →
    True

end SigmaR
