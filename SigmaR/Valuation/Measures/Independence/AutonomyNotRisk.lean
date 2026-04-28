import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Autonomy Not Risk
###############################################################################

This file establishes that autonomy measures do not entail risk load.

An agent may bear significant risk without autonomy loss,
and may suffer autonomy loss without elevated risk.
No implication between these measures is assumed.

Importing this file explicitly rejects any default assumption that
autonomy loss licenses or predicts risk exposure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy measures to risk load.
Any relationship between these quantities must be introduced explicitly.
-/
axiom autonomy_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       AutonomyMeasure a s → RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- reduced autonomy implies danger
- exposure to harm tracks loss of freedom
- risk metrics can stand in for agency constraints

Risk and autonomy are orthogonal diagnostics.
-/
