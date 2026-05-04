import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Depends On Measure
###############################################################################

This file introduces structural dependency of transformability
valuation on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• optimization
• competence or merit judgment
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnMeasure T M means that transformability
valuation T structurally depends on valuation measure M.
-/
constant TransformabilityDependsOnMeasure :
  TransformabilityValuation → Measure → Prop

end SigmaR
