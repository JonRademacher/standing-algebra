import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Perception Hysteresis
###############################################################################

This file introduces hysteresis in perception valuation.

Hysteresis captures path dependence:
the current perceptual alignment depends on prior states,
not just current context.

It does NOT:
• assign blame
• assert irrationality
• imply moral judgment
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionHysteresis P means that perception valuation P
exhibits path-dependent behavior.
-/
axiom PerceptionHysteresis :
  PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
