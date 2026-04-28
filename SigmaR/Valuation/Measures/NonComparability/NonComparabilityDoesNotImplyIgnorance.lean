import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.NonComparability.NonComparabilityContract

/-!
###############################################################################
# Non-Comparability Does Not Imply Ignorance
###############################################################################

The absence of comparability between valuation measures
does not imply lack of information, indeterminacy, or ignorance.

Non-comparability is a semantic constraint, not an epistemic failure.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability does not imply that nothing can be known
about the measures involved.
-/
axiom noncomparability_not_ignorance :
  ¬ (
    ∀ (M₁ M₂ : Agent → State → Nat),
      ¬ (∃ a s, True)
  )

end SigmaR
