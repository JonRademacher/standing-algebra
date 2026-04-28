import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Standing ≠ Domination Pressure
###############################################################################

This file establishes that standing does not entail
domination pressure.

Standing measures recognized status or admissible participation.
Domination pressure is a system-level diagnostic indicating
structural instability or approach to collapse.

Importing this file explicitly rejects any assumption that
recognized standing prevents or determines domination pressure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to domination pressure.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_domination_pressure :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → DominationPressure s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition stabilizes systemic collapse
- admissible participation blocks domination dynamics
- domination pressure collapses into standing metrics

Standing and domination pressure are distinct structural facts.
-/
