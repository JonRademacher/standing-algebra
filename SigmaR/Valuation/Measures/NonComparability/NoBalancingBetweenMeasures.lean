import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Balancing Between Measures
###############################################################################

Non-comparable measures must not be balanced,
offset, or averaged against each other.
###############################################################################
-/

namespace SigmaR

/--
No balancing is permitted between non-comparable measures.
-/
axiom no_balancing_between_measures :
  ¬ (∃ (B : (Agent → State → Nat) → (Agent → State → Nat) → Nat),
        True)

end SigmaR
