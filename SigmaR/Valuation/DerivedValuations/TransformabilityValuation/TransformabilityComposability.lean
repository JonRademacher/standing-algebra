import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Composability
###############################################################################

This file introduces composability of transformability.

Composability captures the ability to combine operations
to form higher-order transformations.

This is where abstraction structurally emerges.

It does NOT:
• imply creativity
• imply intelligence
• imply preference
###############################################################################
-/

namespace SigmaR

/--
TransformabilityComposability T means that transformability
valuation T admits compositional transformation.
-/
constant TransformabilityComposability :
  TransformabilityValuation → Prop

end SigmaR
