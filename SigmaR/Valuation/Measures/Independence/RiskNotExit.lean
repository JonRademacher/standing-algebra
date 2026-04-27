import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Risk ≠ Exit Viability
###############################################################################

This file establishes that risk exposure does not entail
exit viability.

Risk load captures exposure to harm or uncertainty.
Exit viability concerns the structural availability of
refusal or escape.

An agent may face low risk without a viable exit,
or retain a viable exit while exposed to risk.

Importing this file explicitly rejects any assumption that
risk exposure determines exit viability.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk load
to exit viability.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_exit :
  ¬ (∀ (a : Agent) (s : State),
       RiskLoad a s → ExitViable a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- safety implies freedom to leave
- low exposure guarantees escape
- exit collapses into risk metrics

Risk and exit viability are distinct structural facts.
-/

