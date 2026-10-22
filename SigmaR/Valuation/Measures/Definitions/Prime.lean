import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Prime
###############################################################################

This file introduces the primitive predicate Prime.

Prime is intentionally uninterpreted at this layer.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Prime i indicates that agent i is treated as irreducible
under some theory or model.
-/
axiom Prime : Agent → Prop

end SigmaR.Valuation.Measures.Definitions
