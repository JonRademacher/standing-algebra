import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Equivalence.EquivalenceContract

/-!
###############################################################################
# Equivalence Does Not Imply Persistence
###############################################################################

Equivalence between measures does not imply
that the equivalence persists across states or contexts.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not persist by default.
-/
axiom equivalence_not_persistent :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s₁ s₂,
        M₁ a s₁ = M₂ a s₁ →
        M₁ a s₂ = M₂ a s₂)

end SigmaR
