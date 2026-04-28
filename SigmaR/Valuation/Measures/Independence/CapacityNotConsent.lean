import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Capacity Not Consent
###############################################################################

This file establishes that capacity does not entail consent.

Capacity expresses potential or ability.
Consent is an affirmative act at the level of standing or agency.
No implication from capacity measures to consent is assumed.

Importing this file explicitly rejects any default assumption that
ability licenses agreement.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures to consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom capacity_not_consent :
  ¬ (∀ (i : Agent) (s : State),
       CapacityMeasure i s → Consent i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- ability implies agreement
- competence substitutes for authorization
- functional readiness licenses consent

Consent is an act, not a capacity threshold.
-/
