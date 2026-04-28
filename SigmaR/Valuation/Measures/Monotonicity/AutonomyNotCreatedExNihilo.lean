import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Autonomy Not Created Ex Nihilo
###############################################################################

Autonomy does not arise spontaneously without enabling structure.
###############################################################################
-/

namespace SigmaR

axiom autonomy_not_created_ex_nihilo :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    AutonomyMeasure a s₁ ≤ AutonomyMeasure a s₂

end SigmaR
