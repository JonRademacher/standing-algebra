import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Admissible
###############################################################################

This file governs admissibility of responses under
declared structural constraints.

Admissibility does NOT imply:
• authorization
• obligation
• intervention
###############################################################################
-/

namespace SigmaR.Valuation.ResponseSemantics

/--
ResponseAdmissible R means that response R
is permitted within the response semantics layer
under declared constraints.
-/
axiom ResponseAdmissible :
  Response → Prop

end SigmaR.Valuation.ResponseSemantics
