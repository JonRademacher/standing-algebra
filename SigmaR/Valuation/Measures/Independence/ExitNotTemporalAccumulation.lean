import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Temporal Accumulation
###############################################################################

This file establishes that exit viability does not entail
temporal accumulation of constraint.

Exit viability concerns the present availability of refusal
or withdrawal.
Temporal accumulation tracks irreversible or narrowing
constraint over time.

Importing this file explicitly rejects any assumption that
the availability of exit determines accumulated constraint.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to temporal accumulation.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_temporal_accumulation :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → TemporalAccumulation a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- present exit options negate historical harm
- withdrawal capacity blocks accumulation
- irreversible constraint collapses into exit viability

Exit viability and temporal accumulation are distinct
structural facts.
-/

