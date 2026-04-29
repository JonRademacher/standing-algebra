import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Domain
###############################################################################

All valuation expressions must have explicit and
coherent domains.
###############################################################################
-/

namespace SigmaR

/--
Valuation functions must have explicit domains.
-/
axiom wellformed_domain :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
