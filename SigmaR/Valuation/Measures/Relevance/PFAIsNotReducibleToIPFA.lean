import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# PFA Is Not Reducible to IPFA
###############################################################################

Collective perceptual agreement is not reducible
to a collection of individual personal warrants.
###############################################################################
-/

namespace SigmaR

/--
PFA is not equivalent to a conjunction of IPFAs.
-/
axiom pfa_not_reducible_to_ipfa :
  ∀ (G : Set Agent) (s : State),
    PFA G s →
    ¬ (∀ a ∈ G, IPFA a s)

end SigmaR
