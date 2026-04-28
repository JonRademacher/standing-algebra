import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Structural Debt Is Monotone
###############################################################################

Structural debt does not decrease without explicit repair.
###############################################################################
-/

namespace SigmaR

axiom structural_debt_monotone :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    StructuralDebt a s₁ ≤ StructuralDebt a s₂

end SigmaR
