import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition
import SigmaR.Valuation.Measures.Relevance.PFA_Definition

/-!
###############################################################################
# Personal Warrant Is Insufficient for Plurality
###############################################################################

Individual personal warrants do not, by themselves,
constitute collective perceptual agreement.
###############################################################################
-/

namespace SigmaR

/--
IPFA alone is insufficient to establish PFA.
-/
axiom ipfa_insufficient_for_pfa :
  ∀ (G : Set Agent) (s : State),
    (∀ a ∈ G, IPFA a s) →
    ¬ PFA G s

end SigmaR
