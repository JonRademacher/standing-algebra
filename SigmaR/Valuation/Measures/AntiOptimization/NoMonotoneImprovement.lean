import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Monotone Improvement
###############################################################################

Monotonicity does not imply improvement, benefit,
or desirability.

A value may evolve monotonically without becoming "better".
###############################################################################
-/

namespace SigmaR

/--
There is no assumption that monotone change constitutes improvement.
-/
axiom no_monotone_improvement :
  ∀ (M : Agent → State → Nat),
    ¬ (∀ a s₁ s₂,
        M a s₁ ≤ M a s₂ →
        True)

end SigmaR
