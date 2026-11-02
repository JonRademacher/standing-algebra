import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

/-!
###############################################################################
# Standing Threshold
###############################################################################

This file introduces the notion of thresholds
within standing valuation.

Thresholds do NOT imply:
• collapse
• intervention
• legitimacy
• moral judgment

They are structural demarcations only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingThreshold S means that standing valuation S
is associated with a structural threshold.
-/
axiom StandingThreshold :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
