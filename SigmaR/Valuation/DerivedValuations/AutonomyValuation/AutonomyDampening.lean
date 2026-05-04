import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Dampening
###############################################################################

This file introduces dampening of autonomy effects.

Dampening captures structural conditions under which
autonomy loss or constraint is buffered or reduced.

It does NOT:
• imply restoration
• assert sufficiency
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyDampening A₁ A₂ means that autonomy valuation A₁
dampens the autonomy effects represented by A₂.
-/
constant AutonomyDampening :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR
