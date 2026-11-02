import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

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

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
AutonomyThreshold A means that autonomy valuation A
is associated with a structural threshold.
-/
axiom AutonomyThreshold :
  AutonomyValuation → Prop

end SigmaR.Valuation.DerivedValuations.AutonomyValuation
