import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityScope

/-!
###############################################################################
# Monotonicity Non-Totality
###############################################################################

The state ordering used for monotonicity need not be total.

Not all states are required to be comparable.
###############################################################################
-/

namespace SigmaR

/--
State progression is not assumed to be a total order.
-/
axiom state_order_not_total :
  ¬ (∀ (s₁ s₂ : State),
        StateLe s₁ s₂ ∨ StateLe s₂ s₁)

end SigmaR
