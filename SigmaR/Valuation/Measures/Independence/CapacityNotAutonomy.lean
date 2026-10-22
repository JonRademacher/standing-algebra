import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition

open SigmaR.Valuation.Core

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

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing autonomy is permitted.
-/
axiom capacity_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
