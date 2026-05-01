import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Interfering
###############################################################################

This file introduces the notion of response interference.

Interference means that responses cannot be freely composed
without altering or invalidating effects.

It does NOT imply:
• conflict resolution
• prioritization
• authority
###############################################################################
-/

namespace SigmaR

/--
ResponseInterfering R₁ R₂ means that responses R₁ and R₂
structurally interfere with one another.
-/
constant ResponseInterfering :
  Response → Response → Prop

end SigmaR
