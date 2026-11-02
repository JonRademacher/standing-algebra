import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Equivalence.EquivalenceContract

/-!
###############################################################################
# Non-Comparability Does Not Imply Equivalence
###############################################################################

The absence of a comparison relation does not imply
equivalence or sameness.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.NonComparability

/--
Non-comparability does not imply equivalence.
-/
axiom noncomparability_not_equivalence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s = M₂ a s)

end SigmaR.Valuation.Measures.NonComparability
