import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Scalarization
###############################################################################

Distinct valuation dimensions must not be collapsed into
a single scalar quantity by default.
###############################################################################
-/

namespace SigmaR

/--
There is no canonical scalarization of multiple measures.
-/
axiom no_scalarization :
  ¬ (∃ (F : (Agent → State → Nat) → Nat),
        ∀ (M : Agent → State → Nat),
          True)

end SigmaR
