import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Definition Non-Equivalence
###############################################################################

Distinct valuation concepts must not be definitionally
or semantically collapsed at the level of primitive
definitions.

Any equivalence between distinct concepts must be
introduced explicitly and locally, never implicitly
at the definition layer.
###############################################################################
-/

namespace SigmaR

/--
No implication from the mere existence of valuation
definitions to equivalence or identity of distinct
valuation measures is permitted.
-/
axiom definition_non_equivalence :
  ¬ (
    ∀ (M₁ M₂ : Measure),
      IsMeasure M₁ →
      IsMeasure M₂ →
      EquivalentMeasures M₁ M₂
  )

end SigmaR
