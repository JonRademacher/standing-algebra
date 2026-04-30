import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Kind
###############################################################################

This file introduces structural categories of responses,
such as repair, containment, redesign, or exit.

Response kinds are classificatory only and do NOT imply:
• moral evaluation
• preference
• authority
• correctness

They exist to distinguish response structure, not value.
###############################################################################
-/

namespace SigmaR

/--
A structural classification of responses.
-/
constant ResponseKind : Response → Prop

end SigmaR
