import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Risk ≠ Autonomy
###############################################################################

This file establishes that risk exposure does not entail
loss of autonomy.

Risk load captures exposure to harm or uncertainty.
Autonomy measures freedom from coercive constraint.

An agent may face significant risk while retaining autonomy,
or lose autonomy without elevated risk.

Importing this file explicitly rejects any assumption that
risk exposure determines autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk load
to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       RiskLoad a s → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- danger implies unfreedom
- exposure substitutes for coercion
- autonomy collapses into risk metrics

Risk and autonomy are distinct structural dimensions.
-/
