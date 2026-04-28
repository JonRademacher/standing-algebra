import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Standing ≠ Temporal Accumulation
###############################################################################

This file establishes that standing does not entail
temporal accumulation of constraint.

Standing measures recognized status or admissible participation.
Temporal accumulation tracks irreversible or narrowing
structural constraint over time.

Importing this file explicitly rejects any assumption that
recognized standing determines accumulated constraint.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to temporal accumulation.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_temporal_accumulation :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → TemporalAccumulation a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition hardens into irreversible harm
- admissibility substitutes for historical constraint
- standing collapses into accumulated damage

Standing and temporal accumulation are distinct structural facts.
-/

