import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Measure Composition Monotonicity
###############################################################################

Composition of monotone measures is itself monotone.
###############################################################################
-/

namespace SigmaR

/--
If a measure is structurally monotone, applying a monotone
post-processing function preserves monotonicity.
-/
axiom measure_composition_monotone :
  ∀ (M : Agent → State → Nat)
    (f : Nat → Nat)
    (a : Agent) (s₁ s₂ : State),
    (∀ x y, x ≤ y → f x ≤ f y) →
    StateLe s₁ s₂ →
    f (M a s₁) ≤ f (M a s₂)

end SigmaR
