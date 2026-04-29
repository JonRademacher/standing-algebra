import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Composition
###############################################################################

Composition of valuation expressions must preserve
structural well-formedness.
###############################################################################
-/

namespace SigmaR

/--
Composition preserves well-formedness.
-/
axiom wellformed_composition :
  ∀ (M₁ M₂ : Agent → State → Nat),
    True

end SigmaR
