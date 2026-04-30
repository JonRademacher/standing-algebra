import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Capacity
###############################################################################

Exit viability does not license or imply agent capacity.

Exit viability concerns the availability of non-coercive refusal
or escape.
Capacity measures agent-level ability or potential.

No default implication from exit viability to capacity
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit viability as constituting
or licensing capacity is permitted.
-/
axiom exit_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromExitViable a s
  )

end SigmaR
