import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Does Not Permit Substitution
###############################################################################

Non-comparability does not allow one valuation measure
to be substituted for another.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability does not license substitution.
-/
axiom noncomparability_no_substitution :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s → M₂ a s)

end SigmaR
