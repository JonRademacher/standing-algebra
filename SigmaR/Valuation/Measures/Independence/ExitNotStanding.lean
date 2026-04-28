import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Standing
###############################################################################

This file establishes that exit viability does not entail standing.

Standing tracks recognition under admissible participation.
Exit viability tracks the structural ability to refuse or withdraw.

Importing this file explicitly rejects any assumption that
the availability of exit constitutes standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to standing.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → StandingMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- the ability to refuse implies recognition
- exit substitutes for standing
- withdrawal capacity collapses into admissible participation

Exit viability and standing are distinct structural facts.
-/

