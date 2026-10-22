import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Threshold
###############################################################################

This file introduces thresholds in transformability valuation.

Thresholds represent structural demarcations where
transformability behavior changes qualitatively.

They do NOT:
• mandate action
• imply collapse by default
• assert normative evaluation
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityThreshold T means that transformability valuation T
is associated with a structural threshold.
-/
axiom TransformabilityThreshold :
  TransformabilityValuation → Prop

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
