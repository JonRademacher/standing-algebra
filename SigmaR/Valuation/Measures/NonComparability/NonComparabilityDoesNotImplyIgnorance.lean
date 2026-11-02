import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.NonComparability.NonComparabilityContract

open SigmaR.Valuation.Core

/-!
###############################################################################
# Non-Comparability Does Not Imply Ignorance
###############################################################################

The absence of comparability between valuation measures
does not imply lack of information, indeterminacy, or ignorance.

Non-comparability is a semantic constraint, not an epistemic failure.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.NonComparability

/--
No implication treating non-comparability as epistemic
ignorance or indeterminacy is permitted.
-/
axiom noncomparability_not_ignorance :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      TreatedAsIgnorance M₁ M₂
  )

end SigmaR.Valuation.Measures.NonComparability
