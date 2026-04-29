import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Tradeoff Justification
###############################################################################

The valuation system does not permit justification of harm
in one measure by improvement in another.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting tradeoff-based justification
between valuation measures is allowed.
-/
axiom no_tradeoff_justification :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      M₁ ≠ M₂ ∧
      TradeoffJustifies M₁ M₂
  )

end SigmaR

