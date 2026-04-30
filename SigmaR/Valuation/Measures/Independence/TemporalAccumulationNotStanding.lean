import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Standing
###############################################################################

Temporal accumulation does not license or imply loss,
revocation, or determination of standing.

Temporal accumulation captures time-binding and irreversible
structural constraint over time.
Standing measures recognized status or admissible participation
within a system.

No default implication from temporal accumulation to standing
is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating temporal accumulation as determining,
revoking, or licensing standing is permitted.
-/
axiom temporal_accumulation_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromTemporalAccumulation a s
  )

end SigmaR
