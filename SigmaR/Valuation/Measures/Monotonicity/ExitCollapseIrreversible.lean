import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Collapse Is Irreversible
###############################################################################

Exit collapse cannot be undone by state progression alone.
###############################################################################
-/

namespace SigmaR

axiom exit_collapse_irreversible :
  ∀ (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    ExitCollapse a s₁ →
    ExitCollapse a s₂

end SigmaR
