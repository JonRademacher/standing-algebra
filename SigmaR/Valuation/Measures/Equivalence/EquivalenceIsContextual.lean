import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Equivalence Is Contextual
###############################################################################

Equivalence holds only within an explicit context
and does not persist universally.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Equivalence

/--
No implication asserting context-free or global
equivalence between valuation measures is permitted.
-/
axiom equivalence_is_contextual :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      EquivalentMeasures M₁ M₂ ∧
      (∀ (C : EquivalenceContext),
         EquivalentInContext C M₁ M₂)
  )

end SigmaR.Valuation.Measures.Equivalence
