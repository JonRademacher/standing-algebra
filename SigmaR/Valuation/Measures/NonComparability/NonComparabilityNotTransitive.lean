import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Non-Comparability Not Transitive
###############################################################################

Non-comparability is not transitive by default.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting transitive propagation of
non-comparability between valuation measures is
permitted by default.
-/
axiom noncomparability_not_transitive :
  ¬ (
    ∃ (M₁ M₂ M₃ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      IsMeasure M₃ ∧
      NonComparable M₁ M₂ ∧
      NonComparable M₂ M₃ ∧
      NonComparable M₁ M₃
  )

end SigmaR

