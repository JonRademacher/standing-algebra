import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating autonomy as entailing or
licensing assumptions about capacity is permitted.
-/
axiom autonomy_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromAutonomy a s
  )

end SigmaR.Valuation.Measures.Independence
