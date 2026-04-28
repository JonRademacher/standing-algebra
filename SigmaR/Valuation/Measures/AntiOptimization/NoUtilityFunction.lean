import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Utility Function
###############################################################################

Valuation measures in SigmaR are not utilities.
They are not assumed to represent preference satisfaction,
welfare, or optimality.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure is assumed to be a utility function.
-/
axiom no_utility_function :
  ¬ (∃ (U : Agent → State → Nat),
        ∀ (a : Agent) (s : State),
          True)

end SigmaR
