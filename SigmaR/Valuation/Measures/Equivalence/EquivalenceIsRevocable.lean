import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Equivalence.EquivalenceContract

/-!
###############################################################################
# Equivalence Is Revocable
###############################################################################

Declared equivalence between measures may cease to hold
when its defining context or conditions change.
###############################################################################
-/

namespace SigmaR

/--
Equivalence may be revoked when context changes.
-/
axiom equivalence_revocable :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ∃ (a : Agent) (s₁ s₂ : State),
      M₁ a s₁ = M₂ a s₁ ∧
      M₁ a s₂ ≠ M₂ a s₂

end SigmaR
