import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Autonomy Not Temporal Accumulation
###############################################################################

Present autonomy does not license or imply temporal
accumulation of constraint. Any relationship must be
introduced explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating autonomy measures as implying
or licensing assumptions of temporal accumulation is permitted.
-/
axiom autonomy_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationFromAutonomyMeasure a s
  )

end SigmaR
