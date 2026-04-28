import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityScope

/-!
###############################################################################
# Monotonicity Does Not Imply Persistence
###############################################################################

Monotonicity does not guarantee that a property,
once true, remains true.
###############################################################################
-/

namespace SigmaR

/--
Monotonic constraints do not imply persistence of values.
-/
axiom monotonicity_not_persistence :
  ∀ (M : Agent → State → Nat),
    ¬ (∀ a s₁ s₂,
        StateLe s₁ s₂ →
        M a s₁ = M a s₂)

end SigmaR
