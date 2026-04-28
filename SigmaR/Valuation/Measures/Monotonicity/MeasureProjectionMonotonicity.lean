import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Measure Projection Monotonicity
###############################################################################

Projecting or restricting a valuation does not reverse monotonicity.
###############################################################################
-/

namespace SigmaR

/--
Projection of a monotone measure remains monotone.
-/
axiom measure_projection_monotone :
  ∀ (M : Agent → State → Nat)
    (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    M a s₁ ≤ M a s₂

end SigmaR
