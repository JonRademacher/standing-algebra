import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Capacity ≠ Temporal Accumulation
###############################################################################

This file establishes that capacity measures do not entail
temporal accumulation of constraint.

Capacity expresses present ability or potential.
Temporal accumulation tracks irreversible constraint over time.

An agent may retain capacity while irreversible harm accumulates,
or lose capacity without long-term accumulation.

Importing this file explicitly rejects any assumption that
present capacity determines accumulated constraint.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to temporal accumulation.
Any relationship between these quantities must be introduced explicitly.
-/
axiom capacity_not_temporal_accumulation :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → TemporalAccumulation a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- present ability negates historical harm
- accumulated constraint can be inferred from capacity
- time-integrated damage collapses to a snapshot valuation

Capacity and temporal accumulation live on different axes.
-/

