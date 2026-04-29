import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Tradeoffs Between Measures
###############################################################################

Non-comparable valuation measures admit no tradeoff
or compensatory reasoning.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting tradeoff or compensatory
reasoning between non-comparable valuation measures
is allowed.
-/
axiom no_tradeoffs_between_measures :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      TradeoffJustifies M₁ M₂
  )

end SigmaR

