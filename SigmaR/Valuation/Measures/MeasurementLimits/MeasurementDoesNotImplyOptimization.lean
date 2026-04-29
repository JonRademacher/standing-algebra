import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Measurement Does Not Imply Optimization
###############################################################################

Measurement does not imply that the system is to be
optimized, improved, or maximized.

Observation does not license optimization.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement to optimization is permitted.
-/
axiom measurement_not_optimization :
  ¬ (
    ∀ (a : Agent) (s : State) (O : State → Nat),
      Observable a s →
      Optimizes O
  )

end SigmaR
