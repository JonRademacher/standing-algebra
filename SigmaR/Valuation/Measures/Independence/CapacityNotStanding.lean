import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Independence: Capacity Not Standing
###############################################################################

This file establishes that standing does not entail capacity.

Standing reflects recognized position or status.
Capacity expresses agent-internal ability or potential.
An agent may retain standing while lacking capacity.

Importing this file explicitly rejects any default assumption that
standing licenses capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing measures
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
- recognized status implies ability
- institutional position substitutes for capacity
- standing metrics can proxy agent competence

Standing and capacity are structurally distinct.
-/
