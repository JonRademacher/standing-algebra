import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Equivalence Scope
###############################################################################

Equivalence between valuation measures is always scoped
to an explicit context.

Equivalence is not global, not timeless, and not implicit.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting equivalence without an explicit
scope or context is permitted.
-/
axiom equivalence_requires_scope :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      EquivalentMeasures M₁ M₂ ∧
      (¬ ∃ (C : EquivalenceContext),
         EquivalentInContext C M₁ M₂)
  )

end SigmaR

