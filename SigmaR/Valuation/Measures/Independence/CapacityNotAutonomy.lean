import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Capacity Not Autonomy
###############################################################################

Capacity expresses potential or ability.
Autonomy expresses freedom from coercive constraint.

No default implication from capacity measures to autonomy
is licensed. Any relationship must be introduced explicitly
in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating capacity measures as implying
or licensing autonomy is permitted.
-/
axiom capacity_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromCapacityMeasure a s
  )

end SigmaR
