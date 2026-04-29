import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed No Circular Dependency
###############################################################################

Valuation constructions must not participate in circular
dependency structures.

This file prevents indirect self-dependence and cyclic
valuation graphs.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may be part of a circular dependency
chain.
-/
axiom no_circular_dependency :
  ¬ (
    ∃ (M₁ M₂ : Agent → State → Nat),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      DependsOn M₁ M₂ ∧
      DependsOn M₂ M₁
  )

end SigmaR

