import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Capacity
###############################################################################

This file establishes that temporal accumulation does not entail
loss of capacity.

Temporal accumulation captures irreversible or narrowing constraint
over time.
Capacity captures present ability or potential.

Irreversible harm may accumulate without immediately reducing
capacity, and capacity may be constrained without irreversible
accumulation.

Importing this file explicitly rejects any assumption that
accumulated constraint determines present capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from temporal accumulation
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom temporal_accumulation_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       TemporalAccumulation a s → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- irreversible harm automatically destroys capacity
- historical constraint substitutes for present ability
- capacity collapses into time-integrated damage

Temporal accumulation and capacity are distinct structural facts.
-/

