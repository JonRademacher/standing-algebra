import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.TemporalAccumulation_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Standing Not Temporal Accumulation
###############################################################################

Standing does not license or imply temporal accumulation of constraint.

Standing measures recognized status or admissible participation.
Temporal accumulation tracks irreversible or narrowing structural
constraint over time.

No default implication from standing to temporal accumulation
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating standing as implying,
licensing, or determining temporal accumulation
is permitted.
-/
axiom standing_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationFromStandingMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
