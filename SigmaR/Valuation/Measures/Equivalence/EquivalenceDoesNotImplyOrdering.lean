import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Equivalence Does Not Imply Ordering
###############################################################################

Equivalence does not induce an ordering over
agents, states, or measures.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Equivalence

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

end SigmaR.Valuation.Measures.Equivalence

