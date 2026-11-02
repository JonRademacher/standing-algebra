import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Standing
###############################################################################

Standing reflects recognized position or status.
Autonomy measures freedom from coercive constraint.

No default implication from standing to autonomy is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing measures as implying
or licensing autonomy is permitted.
-/
axiom standing_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : SigmaR.Valuation.State),
      SigmaR.Valuation.Core.TreatedAsAutonomyFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
