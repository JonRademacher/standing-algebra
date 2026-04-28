import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Not Transitive by Default
###############################################################################

Declared equivalence between two measures does not
automatically propagate transitively.
###############################################################################
-/

namespace SigmaR

/--
Equivalence is not transitive unless explicitly stated.
-/
axiom equivalence_not_transitive_by_default :
  ¬ (∀ (M₁ M₂ M₃ : Agent → State → Nat),
        True)

end SigmaR
