import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
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
No implication treating non-comparability as implying
inaction or impossibility of response is permitted.
-/
axiom noncomparability_not_inaction :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      TreatedAsInaction M₁ M₂
  )

end SigmaR

