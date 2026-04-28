import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Imply Comparability
###############################################################################

Equivalence between valuation measures does not
permit comparison or dominance reasoning.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not imply that two measures are comparable.
-/
axiom equivalence_not_comparable :
  ¬ (∀ (M₁ M₂ : Agent → State → Nat)
        (a : Agent) (s : State),
        M₁ a s ≤ M₂ a s ∨ M₂ a s ≤ M₁ a s)

end SigmaR
