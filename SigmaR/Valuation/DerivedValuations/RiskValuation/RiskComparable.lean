import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Comparable
###############################################################################

This file introduces comparability semantics for
risk valuations.

Comparability does NOT imply:
• moral ranking
• blame assignment
• priority ordering
• authority

It is structural only.
###############################################################################
-/

namespace SigmaR

/--
RiskComparable R₁ R₂ means that risk valuations
R₁ and R₂ are structurally comparable.
-/
constant RiskComparable :
  RiskValuation → RiskValuation → Prop

end SigmaR
