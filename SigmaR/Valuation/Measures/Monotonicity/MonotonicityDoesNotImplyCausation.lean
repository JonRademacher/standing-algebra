import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Does Not Imply Causation
###############################################################################

Monotonicity of one measure does not entail causal influence
over another measure.
###############################################################################
-/

namespace SigmaR

axiom monotonicity_does_not_imply_causation :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s₁ s₂,
        StateLe s₁ s₂ →
        M₁ a s₁ ≤ M₁ a s₂ →
        M₂ a s₁ ≤ M₂ a s₂)

end SigmaR
