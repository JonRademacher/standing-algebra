import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Comparable
###############################################################################

This file introduces comparability semantics
specific to standing valuations.

Comparability does NOT imply:
• moral ranking
• authority
• justification for action

It is structural only.
###############################################################################
-/

namespace SigmaR

/--
StandingComparable S₁ S₂ means that standing valuations
S₁ and S₂ are structurally comparable.
-/
constant StandingComparable :
  StandingValuation → StandingValuation → Prop

end SigmaR
