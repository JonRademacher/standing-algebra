import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Response Affects Transformability Valuation
###############################################################################

This file introduces the structural notion that a response
affects transformability valuation.

This captures downstream effects on effective transformability
resulting from changes to agreement, scope, or operation sets.

It does NOT:
• authorize action
• imply preference
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsTransformabilityValuation R T means that response R
has a structural effect on transformability valuation T.
-/
constant ResponseAffectsTransformabilityValuation :
  Response → TransformabilityValuation → Prop

end SigmaR
