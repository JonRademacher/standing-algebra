import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as constituting,
generating, or licensing autonomy is permitted.
-/
axiom standing_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
