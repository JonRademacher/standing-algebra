import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Definition No Dynamics
###############################################################################

Definitions must be static mappings.

They must not encode or imply temporal progression,
state evolution, or dynamic behavior.

Dynamics are introduced only in Monotonicity,
Intervention, or explicit models.
###############################################################################
-/

namespace SigmaR

/--
No implication from the mere existence of a valuation
definition to dynamic, temporal, or evolutionary
interpretation is permitted.
-/
axiom definition_no_dynamics :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      (Converges M ∨
       HasEquilibrium M ∨
       HasFixedPoint M ∨
       GuaranteesProgress M)
  )

end SigmaR
