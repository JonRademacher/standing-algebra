import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Relevance Does Not Imply Obligation
###############################################################################

Epistemic relevance does not entail obligation, duty,
or required action.

Relevance constrains consideration, not resolution.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting relevance to generate
obligation, duty, or required action is allowed.
-/
axiom relevance_does_not_imply_obligation :
  ¬ (
    ∀ (a : Agent) (s : State),
      IPFA a s →
      TreatedAsObligatory s
  )

end SigmaR
