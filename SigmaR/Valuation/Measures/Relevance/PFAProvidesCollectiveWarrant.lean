import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition

/-!
###############################################################################
# PFA Provides Collective Warrant
###############################################################################

Perceptual Frame Agreement provides a collective
relevance warrant for the group involved.
###############################################################################
-/

namespace SigmaR

/--
PFA provides a collective relevance warrant,
and nothing beyond that.
-/
axiom pfa_provides_collective_warrant :
  ∀ (G : Set Agent) (s : State),
    PFA G s →
    True

end SigmaR
