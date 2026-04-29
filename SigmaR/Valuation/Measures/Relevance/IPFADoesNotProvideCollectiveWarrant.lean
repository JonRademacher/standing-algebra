import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
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
No implication permitting IPFA to generate collective
or transferable warrant is allowed.
-/
axiom ipfa_not_collective :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      (∀ a ∈ G, IPFA a s) →
      TreatedAsAuthoritative s
  )

end SigmaR


end SigmaR
