import SigmaR.StandingAlgebra_FormalCore

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
A relevance warrant is scoped to a particular agent
and state context.
-/
axiom relevance_is_scoped :
  ∀ (a₁ a₂ : Agent) (s₁ s₂ : State),
    a₁ ≠ a₂ ∨ s₁ ≠ s₂

end SigmaR
