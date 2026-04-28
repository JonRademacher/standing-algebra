import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Capacity
###############################################################################

This file establishes that no implication from `AutonomyMeasure`
to `CapacityMeasure` is derivable within `SigmaR.Valuation.Measures`.

Autonomy expresses freedom from coercive constraint.
Capacity expresses potential ability.
These are intentionally independent notions at the level of measures.

Importing this file explicitly rejects any default assumption that
autonomy entails capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy to capacity.
Any relationship between these measures must be introduced explicitly.
-/
axiom autonomy_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       AutonomyMeasure a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- freedom from coercion implies ability
- recognition of agency implies competence
- measured autonomy licenses functional expectations

Such links may exist in specific domains, but are not structural.
-/
