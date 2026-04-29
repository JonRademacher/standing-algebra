import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Scalar Comparison
###############################################################################

Non-comparable measures must not be compared by embedding
them into a shared scalar representation.
###############################################################################
-/

namespace SigmaR

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

end SigmaR

