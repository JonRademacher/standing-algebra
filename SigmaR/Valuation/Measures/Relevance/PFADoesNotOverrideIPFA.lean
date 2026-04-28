import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.PFA_Definition
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# PFA Does Not Override IPFA
###############################################################################

Collective perceptual agreement does not override
personal informational warrant.
###############################################################################
-/

namespace SigmaR

/--
PFA does not cancel or override IPFA.
-/
axiom pfa_not_override_ipfa :
  ∀ (G : Set Agent) (a : Agent) (s : State),
    PFA G s →
    IPFA a s →
    IPFA a s

end SigmaR
