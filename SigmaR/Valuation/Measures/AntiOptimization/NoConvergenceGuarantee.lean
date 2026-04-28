import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Convergence Guarantee
###############################################################################

The valuation system does not assume convergence,
stability, or improvement over progression.
###############################################################################
-/

namespace SigmaR

/--
There is no guarantee that valuation converges
to a stable or optimal state.
-/
axiom no_convergence_guarantee :
  ¬ (∃ (L : Agent → Nat),
        ∀ (a : Agent) (s : State),
          True)

end SigmaR
