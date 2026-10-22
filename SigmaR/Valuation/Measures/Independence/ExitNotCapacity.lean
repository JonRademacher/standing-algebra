import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit viability as constituting
or licensing capacity is permitted.
-/
axiom exit_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromExitViable a s
  )

end SigmaR.Valuation.Measures.Independence
