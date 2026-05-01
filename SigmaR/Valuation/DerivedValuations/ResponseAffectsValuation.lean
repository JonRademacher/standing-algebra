import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Response Affects Valuation
###############################################################################

This file introduces the structural notion that a response
has an effect on a derived valuation.

It does NOT:
• specify direction of effect
• imply desirability or harm
• authorize response execution

It is purely descriptive.
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsValuation R V means that response R
has a structural effect on derived valuation V.
-/
constant ResponseAffectsValuation :
  Response → DerivedValuation → Prop

end SigmaR
