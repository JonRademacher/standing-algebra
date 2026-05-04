import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Loss
###############################################################################

This file introduces the structural notion of autonomy loss.

Autonomy loss does NOT imply:
• injustice
• moral failure
• obligation to repair
• legitimacy of intervention

It is a descriptive valuation change only.
###############################################################################
-/

namespace SigmaR

/--
AutonomyLoss A₁ A₂ means that autonomy valuation A₂
represents a loss relative to autonomy valuation A₁.
-/
constant AutonomyLoss :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR
