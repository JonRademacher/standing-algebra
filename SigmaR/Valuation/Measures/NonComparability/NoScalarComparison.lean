import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Scalar Comparison
###############################################################################

Non-comparable measures must not be compared by embedding
them into a shared scalar representation.
###############################################################################
-/

namespace SigmaR

/--
No scalar comparison is assumed between non-comparable measures.
-/
axiom no_scalar_comparison :
  ¬ (∃ (f : (Agent → State → Nat) → Nat),
        True)

end SigmaR
