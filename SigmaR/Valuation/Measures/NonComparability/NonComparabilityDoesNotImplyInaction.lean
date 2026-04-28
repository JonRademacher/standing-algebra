import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.NonComparability.NonComparabilityContract

/-!
###############################################################################
# Non-Comparability Does Not Imply Inaction
###############################################################################

The absence of comparability between valuation measures
does not imply that action, response, or intervention is impossible.

Non-comparability restricts ordering and tradeoff reasoning,
not the possibility of action.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability does not imply that no action or response may occur.
-/
axiom noncomparability_not_inaction :
  ¬ (
    ∀ (M₁ M₂ : Agent → State → Nat),
      ¬ (∃ (A : State → State), True)
  )

end SigmaR
