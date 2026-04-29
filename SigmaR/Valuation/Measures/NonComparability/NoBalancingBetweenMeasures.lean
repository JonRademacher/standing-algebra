import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Balancing Between Measures
###############################################################################

Non-comparable measures must not be balanced,
offset, or averaged against each other.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting balancing between
non-comparable valuation measures is allowed.
-/
axiom no_balancing_between_measures :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      BalancedAgainst M₁ M₂
  )

end SigmaR
