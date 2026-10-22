import SigmaR_Core

/-!
###############################################################################
# Equivalence Does Not Permit Inference
###############################################################################

Equivalence does not permit inferential transfer
between valuation measures.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Equivalence

/--
Equivalence does not allow inference between measures.
-/
axiom equivalence_no_inference :
  ∀ (M₁ M₂ : Agent → State → Prop),
    ¬ (∀ a s, M₁ a s → M₂ a s)

end SigmaR.Valuation.Measures.Equivalence
