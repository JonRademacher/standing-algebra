import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Viability Not Created Ex Nihilo
###############################################################################

Exit viability cannot arise without structural conditions.
###############################################################################
-/

namespace SigmaR

axiom exit_viability_not_created_ex_nihilo :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    ExitViable a s₁ ≤ ExitViable a s₂

end SigmaR
