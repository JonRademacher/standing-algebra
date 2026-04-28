import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Standing Not Exit Viability
###############################################################################

This file establishes that standing does not entail exit viability.

Standing concerns recognition and admissibility under participation.
Exit viability concerns the structural ability to refuse or withdraw
without coercion.

Importing this file explicitly rejects any assumption that
recognized standing guarantees a viable exit.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to exit viability.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_exit :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → ExitViable a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition guarantees freedom to leave
- admissibility substitutes for non-coercion
- exit viability collapses into standing

Standing and exit viability are distinct structural facts.
-/
