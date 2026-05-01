import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Standing Valuation Contract
###############################################################################

This file defines the governing interpretive rules of the
Standing Valuation sub-layer in SigmaR.

Standing valuation:
• is derived from standing structure and response semantics
• does not redefine standing from the Formal Core
• does not assert legitimacy, morality, or authority
• does not authorize intervention or action
• respects Independence, Monotonicity, Admissibility,
  and ResponseSemantics
• is always explicitly scoped

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
The Standing Valuation layer is governed by an explicit
interpretive contract defining its scope and limits.
-/
constant StandingValuationContract : Prop

end SigmaR
