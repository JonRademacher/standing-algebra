import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition

/-!
###############################################################################
# Independence: Standing Not Consent
###############################################################################

This file establishes that standing does not entail consent.

Standing measures recognized status or admissible participation
within a system.
Consent is an agent-level condition of voluntary agreement.

Importing this file explicitly rejects any assumption that
recognized standing constitutes consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from standing
to consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom standing_not_consent :
  ¬ (∀ (i : Agent) (s : State),
       StandingMeasure i s → Consent i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- recognition implies agreement
- admissibility substitutes for consent
- standing collapses into voluntariness

Standing and consent are distinct structural facts.
-/

