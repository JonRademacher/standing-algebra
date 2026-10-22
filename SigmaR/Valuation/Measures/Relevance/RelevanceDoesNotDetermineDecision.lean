import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Relevance Does Not Determine Decision
###############################################################################

Epistemic relevance constrains consideration, not resolution.
It must not determine decisions, outcomes, or selections.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Relevance

open SigmaR.Valuation.Core

/--
No implication permitting relevance to determine
decision outcomes is allowed.
-/
axiom relevance_does_not_determine_decision :
  ¬ (
    ∀ (a : Agent) (s : State),
      IPFA a s →
      TreatedAsAuthoritative s
  )

end SigmaR.Valuation.Measures.Relevance
