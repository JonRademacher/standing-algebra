import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Capacity
###############################################################################

Autonomy expresses freedom from coercive constraint.
Capacity expresses potential ability.

These notions are intentionally independent at the level
of valuation measures. Any relationship must be introduced
explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating autonomy as entailing or
licensing assumptions about capacity is permitted.
-/
axiom autonomy_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromAutonomy a s
  )

end SigmaR
