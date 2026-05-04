import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Divergence
###############################################################################

This file introduces divergence in transformability valuation.

Divergence captures increasing separation between
transformability valuations across time, context,
or agreement loci.

It does NOT:
• imply error
• imply irrationality
• assert normative deficiency
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDivergence T₁ T₂ means that transformability
valuations T₁ and T₂ are structurally diverging.
-/
constant TransformabilityDivergence :
  TransformabilityValuation → TransformabilityValuation → Prop

end SigmaR
