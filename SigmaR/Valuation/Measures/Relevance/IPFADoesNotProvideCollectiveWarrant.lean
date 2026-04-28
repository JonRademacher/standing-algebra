import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.IPFA_Definition

/-!
###############################################################################
# IPFA Does Not Provide Collective Warrant
###############################################################################

A personal informational warrant does not justify
relevance, obligation, or action for other agents
or collectives.
###############################################################################
-/

namespace SigmaR

/--
IPFA does not generate collective or transferable warrant.
-/
axiom ipfa_not_collective :
  ∀ (a₁ a₂ : Agent) (s : State),
    IPFA a₁ s →
    a₁ ≠ a₂ →
    ¬ IPFA a₂ s

end SigmaR
