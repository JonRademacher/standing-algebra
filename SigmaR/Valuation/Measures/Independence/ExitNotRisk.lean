import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Exit Viability ≠ Risk
###############################################################################

This file establishes that exit viability does not entail
risk exposure.

Exit viability concerns the availability of refusal or escape.
Risk load captures exposure to harm or uncertainty.

An agent may have a viable exit while remaining exposed to risk,
or face risk without a viable exit.

Importing this file explicitly rejects any assumption that
the availability of exit determines risk exposure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to risk load.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- escape availability neutralizes danger
- exit options substitute for safety
- risk collapses into exit viability

Exit viability and risk are distinct structural facts.
-/
