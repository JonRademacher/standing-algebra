import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Permit Substitution
###############################################################################

Equivalence does not allow free substitution of one
valuation measure for another.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not license substitution.
-/
axiom equivalence_no_substitution :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s → M₂ a s)

end SigmaR
