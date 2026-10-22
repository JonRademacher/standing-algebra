import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Decomposability
###############################################################################

This file introduces decomposability of transformability.

Decomposability captures the ability to break transformations
into simpler constituent operations.

It does NOT:
• imply reductionism
• imply loss of abstraction
• assert correctness
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityDecomposability T means that transformability
valuation T admits decomposition into simpler operations.
-/
axiom TransformabilityDecomposability :
  TransformabilityValuation → Prop

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
