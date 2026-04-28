import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.RiskLoad_Definition

/-!
###############################################################################
# Independence: Standing Not Risk
###############################################################################

This file establishes that standing does not entail risk exposure.

Standing measures recognized status or admissible participation.
Risk load captures exposure to harm or uncertainty.

An agent may bear significant risk without standing changing,
and may have standing without elevated risk.

Importing this file explicitly rejects any assumption that
recognized standing determines risk exposure.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to risk load.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_risk :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → RiskLoad a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition implies exposure
- admissible participation substitutes for risk
- standing collapses into hazard metrics

Standing and risk exposure are distinct structural facts.
-/
