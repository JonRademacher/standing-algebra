import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Comparable
###############################################################################

This file introduces the notion of comparability
between derived valuations.

Comparability does NOT imply:
• ordering
• prioritization
• optimization
• tradeoff justification

It is a structural relation only.
###############################################################################
-/

namespace SigmaR

/--
ValuationComparable V₁ V₂ means that derived valuations
V₁ and V₂ are structurally comparable.
-/
constant ValuationComparable :
  DerivedValuation → DerivedValuation → Prop

end SigmaR
