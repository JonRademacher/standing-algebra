import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Autonomy
###############################################################################

Temporal accumulation does not license or imply loss of autonomy.

Temporal accumulation captures irreversible or narrowing constraint
over time.
Autonomy measures present structural freedom from coercive constraint.

No default implication from temporal accumulation to autonomy
loss is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating temporal accumulation as eliminating,
revoking, or licensing the absence of autonomy is permitted.
-/
axiom temporal_accumulation_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyLostFromTemporalAccumulation a s
  )

end SigmaR
