import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Volition
###############################################################################

This file introduces the primitive predicate of volition.

Volition is intentionally uninterpreted and may be
adapter-supplied or domain-instantiated.

It does NOT imply:
• autonomy
• authority
• correctness
• moral responsibility
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Volition i indicates that agent i has a volitional component.
-/
axiom Volition : Agent → Prop

end SigmaR.Valuation.Measures.Definitions
