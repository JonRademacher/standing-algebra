import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Capacity (Measure) ≠ Consent
###############################################################################

Capacity as ability or potential does not entail consent.

Consent is a voluntary participation condition, not
a function of capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to consent.
-/
axiom capacity_not_consent_measure :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → ConsentState a s)

end SigmaR
