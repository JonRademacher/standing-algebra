import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Standing Not Autonomy
###############################################################################

This file establishes that standing does not entail autonomy.

Standing measures recognized status or admissible participation.
Autonomy measures freedom from coercive constraint.

Importing this file explicitly rejects any assumption that
recognized standing constitutes autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition implies freedom
- admissible participation substitutes for autonomy
- standing collapses into liberty

Standing and autonomy are distinct structural facts.
-/

