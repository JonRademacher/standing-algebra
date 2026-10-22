import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Scalar Comparison
###############################################################################

Non-comparable measures must not be compared by embedding
them into a shared scalar representation.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.NonComparability

/--
No implication permitting scalar embedding or comparison
of non-comparable valuation measures is allowed.
-/
axiom no_scalar_comparison :
  ¬ (
    ∃ (M₁ M₂ : Measure) (O : Obj),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparable M₁ M₂ ∧
      Scalarizes {M₁, M₂} O
  )

end SigmaR.Valuation.Measures.NonComparability
