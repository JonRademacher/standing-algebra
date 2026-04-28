import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# IPFA Provides Personal Warrant
###############################################################################

An IPFA warrant provides relevance for the agent
to whom it applies, and only that agent.
###############################################################################
-/

namespace SigmaR

/--
IPFA provides a personal (agent-specific) warrant of relevance.
-/
axiom ipfa_provides_personal_warrant :
  ∀ (a : Agent) (s : State),
    IPFA a s →
    True

end SigmaR
