import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Response Affects Autonomy Valuation
###############################################################################

This file introduces the structural notion that a response
affects autonomy valuation.

This captures downstream effects on effective autonomy
resulting from changes to agreement, risk, exit cost,
capacity, or transformability.

It does NOT:
• authorize action
• imply consent
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
ResponseAffectsAutonomyValuation R A means that response R
has a structural effect on autonomy valuation A.
-/
constant ResponseAffectsAutonomyValuation :
  Response → AutonomyValuation → Prop

end SigmaR
