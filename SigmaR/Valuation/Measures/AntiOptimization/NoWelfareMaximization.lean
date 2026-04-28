import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Welfare Maximization
###############################################################################

SigmaR does not assume that any valuation measure
represents welfare to be maximized.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure is assumed to be a welfare function.
-/
axiom no_welfare_maximization :
  ¬ (∃ (W : Agent → State → Nat),
        ∀ a s,
          True)

end SigmaR
