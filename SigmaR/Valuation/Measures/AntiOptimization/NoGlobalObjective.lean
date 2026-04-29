import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Global Objective
###############################################################################

The SigmaR valuation system does not assume the existence
of any global objective or goal function.

No measure is defined relative to an optimizing target.
###############################################################################
-/

namespace SigmaR

/--
No implication asserting the existence of a globally
governing optimization objective is permitted.
-/
axiom no_global_objective :
  ¬ (
    ∃ (O : Obj),
      GlobalObjective O ∧
      Optimizes O
  )

end SigmaR
