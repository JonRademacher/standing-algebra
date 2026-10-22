import SigmaR_Core

/-!
###############################################################################
# Non-Comparability Does Not Permit Substitution
###############################################################################

Non-comparability does not allow one valuation measure
to be substituted for another.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.NonComparability

/--
Non-comparability does not license substitution.
-/
axiom noncomparability_no_substitution :
  ∀ (M₁ M₂ : Agent → State → Prop),
    ¬ (∀ a s, M₁ a s → M₂ a s)

end SigmaR.Valuation.Measures.NonComparability
