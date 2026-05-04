import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Amplification
###############################################################################

This file introduces amplification of autonomy effects.

Amplification captures structural conditions under which
loss or constraint of autonomy is intensified.

It does NOT:
• imply intent
• assert wrongdoing
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyAmplification A₁ A₂ means that autonomy valuation A₁
amplifies the autonomy effects represented by A₂.
-/
constant AutonomyAmplification :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR
