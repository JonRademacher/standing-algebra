import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Exit Viability Not Autonomy
###############################################################################

Exit viability does not license or imply autonomy.

Exit viability concerns the availability of non-coercive refusal
or escape.
Autonomy measures freedom from coercive constraint.

No default implication from exit viability to autonomy
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit viability as constituting
or licensing autonomy is permitted.
-/
axiom exit_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromExitViable a s
  )

end SigmaR.Valuation.Measures.Independence
