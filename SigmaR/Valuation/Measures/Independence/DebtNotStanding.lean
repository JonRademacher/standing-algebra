import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Structural Debt Not Standing
###############################################################################

This file establishes that structural debt does not entail
loss of standing.

Structural debt tracks unresolved asymmetry or deferred repair
within a system.
Standing measures recognized status or admissible participation.

Importing this file explicitly rejects any assumption that
accumulated debt by itself eliminates standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from structural debt
to loss of standing.
Any relationship between these concepts must be introduced explicitly.
-/
axiom debt_not_standing :
  ¬ (∀ (a : Agent) (s : State),
       StructuralDebt a → ¬ StandingMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- obligation revokes status
- debt excludes participation by definition
- structural asymmetry nullifies standing

Standing and debt are independent structural dimensions.
-/

