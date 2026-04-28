import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Capacity Not Autonomy
###############################################################################

This file establishes that capacity does not entail autonomy.

Capacity expresses potential or ability.
Autonomy expresses freedom from coercive constraint.
An agent may possess capacity while lacking autonomy.

Importing this file explicitly rejects any default assumption that
capacity licenses autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures to autonomy measures.
Any relationship between these quantities must be introduced explicitly.
-/
axiom capacity_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- ability implies freedom
- competence substitutes for autonomy
- functional capacity can proxy coercive constraint

Capacity and autonomy are structurally distinct.
-/
