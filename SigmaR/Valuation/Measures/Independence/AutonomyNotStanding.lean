import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Standing
###############################################################################

This file establishes that standing does not entail autonomy.

Standing may be preserved while autonomy is impaired.
Autonomy is a structural measure of freedom from coercive constraint,
while standing reflects recognized position or status.

Importing this file explicitly rejects any default assumption that
standing licenses autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing measures to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognized standing implies freedom
- legal or social status substitutes for autonomy
- standing metrics can proxy coercive constraint

Standing and autonomy are structurally distinct.
-/
