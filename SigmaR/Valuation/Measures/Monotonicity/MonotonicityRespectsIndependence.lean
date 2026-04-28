import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Independence.IndependenceContract
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityContract

/-!
###############################################################################
# Monotonicity Respects Independence
###############################################################################

This file establishes the boundary between the Monotonicity and
Independence layers.

Monotonicity constrains how measures may evolve with respect to
state progression.
Independence constrains what inferences may be drawn between
distinct measures.

Monotonicity must never be used to reintroduce implications
explicitly blocked by Independence.
###############################################################################
-/

namespace SigmaR

/--
Monotonic evolution of one measure does not license inference
about another measure whose implication is blocked by
the Independence layer.
-/
axiom monotonicity_respects_independence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (
      (∀ a s₁ s₂,
        StateLe s₁ s₂ →
        M₁ a s₁ ≤ M₁ a s₂) →
      (∀ a s₁ s₂,
        StateLe s₁ s₂ →
        M₂ a s₁ ≤ M₂ a s₂)
    )

end SigmaR
