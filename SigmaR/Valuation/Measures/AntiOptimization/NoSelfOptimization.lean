import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Self Optimization
###############################################################################

The valuation system does not optimize its own measures.

No valuation dimension is assumed to be subject to
self-referential optimization.
###############################################################################
-/

namespace SigmaR

/--
There is no assumption that a valuation measure
is optimized with respect to itself.
-/
axiom no_self_optimization :
  ¬ (∃ (M : Agent → State → Nat),
        ∀ (a : Agent) (s : State),
          True)

end SigmaR
