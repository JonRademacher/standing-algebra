import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Conflicts
###############################################################################

This file introduces the structural notion of response conflict.

Conflict means that two responses cannot both be applied
without structural incompatibility.

It does NOT imply:
• prioritization
• resolution
• authority
• moral judgment
###############################################################################
-/

namespace SigmaR

/--
ResponseConflicts R₁ R₂ means that responses R₁ and R₂
cannot be jointly applied without structural inconsistency.
-/
constant ResponseConflicts :
  Response → Response → Prop

end SigmaR
