import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Standing Not Structural Debt
###############################################################################

This file establishes that standing does not entail the
absence or discharge of structural debt.

Standing tracks recognition under admissible participation.
Structural debt tracks unresolved asymmetry and deferred repair
within a system.

Importing this file explicitly rejects any assumption that
recognized standing resolves or eliminates structural debt.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to the absence of structural debt.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_debt :
  ¬ (∀ (a : Agent) (s : State),
       StandingMeasure a s → ¬ StructuralDebt a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition cancels obligation
- admissible participation resolves asymmetry
- standing collapses into debt clearance

Standing and structural debt are distinct structural facts.
-/
