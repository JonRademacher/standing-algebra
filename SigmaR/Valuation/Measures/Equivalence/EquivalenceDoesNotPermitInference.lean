import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Permit Inference
###############################################################################

Equivalence does not permit inferential transfer
between valuation measures.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not allow inference between measures.
-/
axiom equivalence_no_inference :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s → M₂ a s)

end SigmaR
