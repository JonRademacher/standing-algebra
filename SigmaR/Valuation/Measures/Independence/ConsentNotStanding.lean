import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Consent ≠ Standing
###############################################################################

This file establishes that consent does not entail standing.

Consent is an affirmative act or expression.
Standing reflects recognized position, status, or inclusion
within a system.

No implication from consent to standing is assumed.

Importing this file explicitly rejects any assumption that
agreement substitutes for standing.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from consent to standing measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom consent_not_standing :
  ¬ (∀ (i : Agent) (s : State),
       Consent i s → StandingMeasure i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- agreement confers status
- consent substitutes for recognition
- participation implies standing

Standing is structural, not voluntary.
-/

