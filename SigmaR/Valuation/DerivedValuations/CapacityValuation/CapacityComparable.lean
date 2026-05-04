import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Comparable
###############################################################################

This file introduces comparability semantics for
capacity valuations.

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
CapacityComparable C₁ C₂ means that capacity valuations
C₁ and C₂ are structurally comparable.
-/
constant CapacityComparable :
  CapacityValuation → CapacityValuation → Prop

end SigmaR
