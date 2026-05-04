import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityAgreement

/-!
###############################################################################
# Internal Capacity Agreement
###############################################################################

This file introduces internalized capacity agreement.

Internal capacity agreement reflects an agent’s stabilized
self-assessment of effective capacity, potentially accumulated
over time.

It grounds personal warrant and does NOT depend on
external validation.
###############################################################################
-/

namespace SigmaR

/--
InternalCapacityAgreement A means that capacity agreement A
is internalized within a single agent.
-/
constant InternalCapacityAgreement :
  CapacityAgreement → Prop

end SigmaR
