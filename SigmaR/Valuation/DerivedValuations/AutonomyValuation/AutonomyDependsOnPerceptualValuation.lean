import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.PerceptionValuation.PerceptionValuation

/-!
###############################################################################
# Autonomy Depends On Perceptual Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on perceptual valuation.

This captures that perceived constraint, recognition,
or misalignment affects effective autonomy without
collapsing perception into authority.

It does NOT:
• assert correctness
• imply consent
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnPerceptualValuation A P means that autonomy
valuation A is structurally dependent on perceptual valuation P.
-/
constant AutonomyDependsOnPerceptualValuation :
  AutonomyValuation → PerceptionValuation → Prop

end SigmaR
