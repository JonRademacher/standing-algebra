import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Is Contextual
###############################################################################

Equivalence holds only within an explicit context
and does not persist universally.
###############################################################################
-/

namespace SigmaR

/--
Equivalence is not assumed to hold globally.
-/
axiom equivalence_is_contextual :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, True)

end SigmaR
