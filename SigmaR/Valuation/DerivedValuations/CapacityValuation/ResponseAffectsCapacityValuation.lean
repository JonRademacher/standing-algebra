import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Response Affects Capacity Valuation
###############################################################################

This file introduces the structural notion that a response
affects capacity valuation.

This captures downstream effects on effective capacity
resulting from changes to agreement, load, or constraints.

It does NOT:
• authorize action
• imply preference
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsCapacityValuation R C means that response R
has a structural effect on capacity valuation C.
-/
constant ResponseAffectsCapacityValuation :
  Response → CapacityValuation → Prop

end SigmaR
