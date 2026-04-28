import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Definitional Equivalence
###############################################################################

Distinct valuation measures are not definitionally identical.
###############################################################################
-/

namespace SigmaR

/--
Distinct measures are not definitionally equal.
-/
axiom no_definitional_equivalence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    M₁ ≠ M₂

end SigmaR
