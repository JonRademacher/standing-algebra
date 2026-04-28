import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Is Contextual
###############################################################################

Monotonicity applies only within an explicit state ordering
and system context.
###############################################################################
-/

namespace SigmaR

axiom monotonicity_is_contextual :
  ¬ (∀ (M : Agent → State → Nat) (a : Agent) (s₁ s₂ : State),
        M a s₁ ≤ M a s₂)

end SigmaR
