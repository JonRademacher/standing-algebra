import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Non-Comparability Is Contextual
###############################################################################

Non-comparability holds only where explicitly declared.
It is not assumed globally.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting context-free or global
non-comparability between valuation measures is permitted.
-/
axiom noncomparability_is_contextual :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      (∀ (C : NonComparabilityContext),
         NonComparableInContext C M₁ M₂)
  )

end SigmaR

