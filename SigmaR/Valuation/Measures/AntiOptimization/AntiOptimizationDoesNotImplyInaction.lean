import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AntiOptimization.AntiOptimizationContract

/-!
###############################################################################
# AntiOptimization Does Not Imply Inaction
###############################################################################

The absence of optimization assumptions does not imply
that action, intervention, or response is impossible.

AntiOptimization restricts goals and teleology,
not the possibility of action.
###############################################################################
-/

namespace SigmaR

/--
Prohibiting optimization does not imply that
no action or response may occur.
-/
axiom antioptimization_not_inaction :
  ¬ (
    ¬ (∃ (O : State → Nat), True) →
    ¬ (∃ (A : State → State), True)
  )

end SigmaR
