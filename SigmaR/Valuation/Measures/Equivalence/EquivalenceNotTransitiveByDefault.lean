import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Equivalence Not Transitive by Default
###############################################################################

Declared equivalence between two measures does not
automatically propagate transitively.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting transitive closure of
equivalence between valuation measures is permitted
by default.
-/
axiom equivalence_not_transitive_by_default :
  ¬ (
    ∃ (M₁ M₂ M₃ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      IsMeasure M₃ ∧
      EquivalentMeasures M₁ M₂ ∧
      EquivalentMeasures M₂ M₃ ∧
      EquivalentMeasures M₁ M₃
  )

end SigmaR
