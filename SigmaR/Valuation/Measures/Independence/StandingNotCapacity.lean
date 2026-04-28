import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Standing Not Capacity
###############################################################################

This file establishes that standing does not entail capacity.

Standing measures recognized status or admissible participation.
Capacity measures agent ability or potential.

Importing this file explicitly rejects any assumption that
recognized standing constitutes capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition implies ability
- admissibility substitutes for competence
- standing collapses into capacity

Standing and capacity are distinct structural facts.
-/
