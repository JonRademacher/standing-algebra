import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Non-Comparability Is Not Global
###############################################################################

Non-comparability does not apply to all measures
in all contexts by default.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting universal or global
non-comparability between valuation measures
is permitted.
-/
axiom noncomparability_not_global :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      (∀ (C : NonComparabilityContext),
         NonComparableInContext C M₁ M₂)
  )

end SigmaR

