import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Equivalence.EquivalenceScope

/-!
###############################################################################
# Equivalence Is Not Global
###############################################################################

Equivalence between valuation measures is not assumed to
hold globally across all states, agents, or contexts.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting universal or global equivalence
between valuation measures is permitted.
-/
axiom equivalence_not_global :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      (∀ (C : EquivalenceContext),
         EquivalentInContext C M₁ M₂)
  )

end SigmaR

