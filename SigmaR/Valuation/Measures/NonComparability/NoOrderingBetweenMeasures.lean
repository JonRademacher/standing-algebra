import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Ordering Between Measures
###############################################################################

Non-comparable valuation measures admit no ordering
relation between them.
###############################################################################
-/

namespace SigmaR

/--
No ordering relation exists between non-comparable measures.
-/
axiom no_ordering_between_measures :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s ≤ M₂ a s ∨ M₂ a s ≤ M₁ a s)

end SigmaR
