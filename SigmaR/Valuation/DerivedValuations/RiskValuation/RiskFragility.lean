import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Fragility
###############################################################################

This file introduces fragility in risk valuation.

Fragility captures sensitivity of risk exposure
to contextual or structural change.

It does NOT:
• imply negligence
• assert instability as fault
• justify intervention
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.RiskValuation

/--
RiskFragility R means that risk valuation R
is structurally fragile.
-/
axiom RiskFragility :
  RiskValuation → Prop

end SigmaR.Valuation.DerivedValuations.RiskValuation
