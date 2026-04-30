import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Temporal Accumulation
###############################################################################

Exit viability concerns the present availability of refusal
or withdrawal.
Temporal accumulation tracks irreversible or narrowing
constraint over time.

No default implication from exit viability to temporal
accumulation is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating exit viability as implying
or licensing temporal accumulation is permitted.
-/
axiom exit_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationFromExitViable a s
  )

end SigmaR
