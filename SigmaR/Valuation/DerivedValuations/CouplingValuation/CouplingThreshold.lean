import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Threshold
###############################################################################

This file introduces the notion of thresholds
within coupling valuation.

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
CouplingThreshold C means that coupling valuation C
is associated with a structural threshold.
-/
constant CouplingThreshold :
  CouplingValuation → Prop

end SigmaR
