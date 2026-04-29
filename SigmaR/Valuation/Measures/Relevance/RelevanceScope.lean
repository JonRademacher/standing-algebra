import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Relevance Scope
###############################################################################

Relevance warrants apply only within explicitly
specified agent and state contexts.

They are not global and not transferable by default.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting relevance to be treated
as global, agent-independent, or transferable
is allowed.
-/
axiom relevance_is_scoped :
  ¬ (
    ∀ (a₁ a₂ : Agent) (s₁ s₂ : State),
      IPFA a₁ s₁ →
      IPFA a₂ s₂
  )

end SigmaR

