import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Domination Pressure ≠ Standing
###############################################################################

This file establishes that domination pressure does not entail
loss of standing.

Domination pressure is a system-level diagnostic indicating
approach to structural collapse.
Standing measures recognition or admissible participation
within a system.

Importing this file explicitly rejects any assumption that
systemic domination pressure automatically eliminates standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from domination pressure
to loss of standing.
Any relationship between these concepts must be introduced explicitly.
-/
axiom domination_pressure_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       DominationPressure s → ¬ StandingMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- collapse diagnostics revoke recognition
- domination pressure nullifies participation
- standing collapses into system-level instability

Standing and domination pressure are distinct structural dimensions.
-/

end SigmaR
