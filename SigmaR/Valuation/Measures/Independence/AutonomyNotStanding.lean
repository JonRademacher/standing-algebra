import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Standing
###############################################################################

Standing reflects recognized position or status.
Autonomy measures freedom from coercive constraint.

No default implication from standing to autonomy is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing measures as implying
or licensing autonomy is permitted.
-/
axiom standing_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromStandingMeasure a s
  )

end SigmaR
