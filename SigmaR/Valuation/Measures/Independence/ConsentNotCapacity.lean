import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Consent ≠ Capacity
###############################################################################

This file establishes that consent does not entail capacity.

Consent is an affirmative act or expression.
Capacity measures ability or potential.
No implication from consent to capacity is assumed.

Importing this file explicitly rejects any default assumption that
agreement licenses ability.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from consent to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom consent_not_capacity :
  ¬ (∀ (i : Agent) (s : State),
       Consent i s → CapacityMeasure i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- agreement implies ability
- consent substitutes for competence
- authorization licenses capacity

Consent may be given without capacity.
-/

