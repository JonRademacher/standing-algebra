import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Standing Not Autonomy
###############################################################################

Standing does not license or imply autonomy.

Standing measures recognized status or admissible participation.
Autonomy measures freedom from coercive constraint.

No default implication from standing to autonomy
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating standing as constituting,
generating, or licensing autonomy is permitted.
-/
axiom standing_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromStandingMeasure a s
  )

end SigmaR
