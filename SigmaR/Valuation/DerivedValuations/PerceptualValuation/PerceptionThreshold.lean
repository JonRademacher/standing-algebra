import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Threshold
###############################################################################

This file introduces the notion of thresholds
within perception valuation.

Thresholds represent structural demarcations
in perceptual agreement stability.

They do NOT imply:
• error
• collapse by default
• intervention
• legitimacy
###############################################################################
-/

namespace SigmaR

/--
PerceptionThreshold P means that perception valuation P
is associated with a structural threshold.
-/
constant PerceptionThreshold :
  PerceptionValuation → Prop

end SigmaR
