import SigmaR.Valuation.StandingValuation

/-!
###############################################################################
# Operation
###############################################################################

This file introduces abstract operations that may transform agents.

Operations are structural and uninterpreted.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
An abstract operation acting on valuation states.
-/
abbrev Operation := SigmaR.Operation

/--
Application of an operation to a valuation state.
-/
axiom Apply : SigmaR.Operation → SigmaR.Valuation.State → SigmaR.Valuation.State

end SigmaR.Valuation.Measures.Definitions
