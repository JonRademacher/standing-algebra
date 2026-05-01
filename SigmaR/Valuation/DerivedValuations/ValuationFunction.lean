import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Function
###############################################################################

This file introduces valuation functions that map
structural inputs to derived valuations.

Valuation functions do NOT:
• assert optimality
• assert truth
• assert normativity
• assert authority

They are purely computational mappings.
###############################################################################
-/

namespace SigmaR

/--
A valuation function maps agents and states
to derived valuations.
-/
constant ValuationFunction :
  Agent → State → DerivedValuation

end SigmaR
