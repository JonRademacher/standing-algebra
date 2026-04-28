import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Autonomy Not Temporal Accumulation
###############################################################################

This file establishes that present autonomy does not entail
temporal accumulation of constraint.

Autonomy captures current structural freedom.
Temporal accumulation captures irreversible constraint over time.

An agent may retain autonomy while irreversible harm accumulates,
or lose autonomy without long-term accumulation.

Importing this file explicitly rejects any assumption that
present autonomy determines accumulated constraint.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy measures
to temporal accumulation.
Any relationship between these quantities must be introduced explicitly.
-/
axiom autonomy_not_temporal_accumulation :
  ¬ (∀ (a : Agent) (s : State),
       AutonomyMeasure a s → TemporalAccumulation a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- present freedom negates historical harm
- accumulated constraint can be inferred from current autonomy
- time-integrated damage collapses to a snapshot valuation

Temporal accumulation and autonomy live on different axes.
-/

