import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Ranked Operations
###############################################################################

Valuation measures do not induce rankings or orderings
over agents or states by default.
###############################################################################
-/

namespace SigmaR

/--
No canonical ranking of agents or states is assumed.
-/
axiom no_ranked_operations :
  ¬ (∃ (rank : State → Nat),
        True)

end SigmaR
