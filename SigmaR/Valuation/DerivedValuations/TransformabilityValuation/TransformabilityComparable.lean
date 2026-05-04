import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Comparable
###############################################################################

This file introduces comparability semantics for
transformability valuations.

Comparability does NOT imply:
• ranking
• preference
• selection
• authority

It is structural only.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityComparable T₁ T₂ means that transformability
valuations T₁ and T₂ are structurally comparable.
-/
constant TransformabilityComparable :
  TransformabilityValuation → TransformabilityValuation → Prop

end SigmaR
