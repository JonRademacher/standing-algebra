import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

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

namespace SigmaR

/--
StandingThreshold S means that standing valuation S
is associated with a structural threshold.
-/
constant StandingThreshold :
  StandingValuation → Prop

end SigmaR
