import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Capacity ≠ Consent (Measure Independence)
###############################################################################

Capacity does not imply consent.
###############################################################################
-/

namespace SigmaR

/--
Capacity does not entail consent.
-/
axiom CapacityNotConsent :
  ¬ (∀ (i : Agent) (s : State),
      CapacityMeasure i s > 0 → Consent i s)

end SigmaR
