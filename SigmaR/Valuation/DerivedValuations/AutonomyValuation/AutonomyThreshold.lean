import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Autonomy Threshold
###############################################################################

This file introduces the notion of thresholds
within autonomy valuation.

Thresholds do NOT imply:
• collapse
• intervention
• legitimacy
• normative judgment

They are structural demarcations only.
###############################################################################
-/

namespace SigmaR

/--
AutonomyThreshold A means that autonomy valuation A
is associated with a structural threshold.
-/
constant AutonomyThreshold :
  AutonomyValuation → Prop

end SigmaR
