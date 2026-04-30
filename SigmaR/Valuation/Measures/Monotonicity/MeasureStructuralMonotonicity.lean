import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure Structural Monotonicity (Interface)
###############################################################################

This file defines the *structural notion* of monotonicity
for valuation measures with respect to the state preorder.

It does NOT assert that any particular measure is monotone.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure is structurally monotone with respect to
the state preorder.
-/
constant StructurallyMonotone :
  Measure → Prop

end SigmaR
