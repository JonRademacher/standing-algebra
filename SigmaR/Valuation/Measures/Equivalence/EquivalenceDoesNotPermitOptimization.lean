import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Equivalence Does Not Permit Optimization
###############################################################################

Equivalence between valuation measures does not
license optimization or maximization.
###############################################################################
-/

namespace SigmaR

/--
No implication from equivalence to optimization
is permitted.
-/
axiom equivalence_not_optimization :
  ¬ (
    ∃ (M₁ M₂ : Measure) (O : Obj),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      EquivalentMeasures M₁ M₂ ∧
      Optimizes O
  )

end SigmaR

