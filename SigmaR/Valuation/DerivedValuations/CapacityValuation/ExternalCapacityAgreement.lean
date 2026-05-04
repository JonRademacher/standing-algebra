import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityAgreement

/-!
###############################################################################
# External Capacity Agreement
###############################################################################

This file introduces externalized capacity agreement.

External capacity agreement represents stabilized plural
assessment of capacity across agents.

It does NOT:
• override internal capacity agreement
• imply authority or entitlement
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
ExternalCapacityAgreement A means that capacity agreement A
is externalized across multiple agents.
-/
constant ExternalCapacityAgreement :
  CapacityAgreement → Prop

end SigmaR
