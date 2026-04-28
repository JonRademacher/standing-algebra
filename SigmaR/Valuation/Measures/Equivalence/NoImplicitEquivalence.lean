import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Implicit Equivalence
###############################################################################

Equivalence between valuation measures must be declared
explicitly. It is never inferred implicitly.
###############################################################################
-/

namespace SigmaR

/--
No implicit equivalence is assumed between measures.
-/
axiom no_implicit_equivalence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s = M₂ a s)

end SigmaR
