import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Risk ≠ Standing
###############################################################################

This file establishes that risk inheritance does not entail standing.

Risk inheritance captures exposure transmitted through structure,
history, or dependency.
Standing measures recognized status or admissible participation
within a system.

Importing this file explicitly rejects any assumption that
exposure or inherited risk constitutes standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from risk inheritance
to standing.
Any relationship between these concepts must be introduced explicitly.
-/
axiom risk_not_standing :
  ¬ (∀ (i : Agent) (s : State),
       RiskInheritance i s → StandingMeasure i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- exposure confers recognition
- inherited risk substitutes for standing
- vulnerability collapses into admissible participation

Risk inheritance and standing are distinct structural facts.
-/

