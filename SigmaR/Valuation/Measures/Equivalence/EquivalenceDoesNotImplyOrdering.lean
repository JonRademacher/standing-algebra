import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Equivalence Does Not Imply Ordering
###############################################################################

Equivalence does not induce an ordering over
agents, states, or measures.
###############################################################################
-/

namespace SigmaR

/--
No implication from equivalence to induced ordering
or ranking is permitted.
-/
axiom equivalence_not_ordering :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      EquivalentMeasures M₁ M₂ ∧
      EquivalenceInducesOrdering M₁ M₂
  )

end SigmaR

