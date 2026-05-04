import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Depends On Response
###############################################################################

This file introduces structural dependency of capacity
valuation on response semantics.

Dependency does NOT imply:
• endorsement of the response
• justification of intervention
• obligation to act

It is structural sensitivity only.
###############################################################################
-/

namespace SigmaR

/--
CapacityDependsOnResponse C R means that capacity valuation C
is structurally sensitive to response R.
-/
constant CapacityDependsOnResponse :
  CapacityValuation → Response → Prop

end SigmaR
