import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Does Not Imply Comparability
###############################################################################

Relevance does not permit comparison, ranking,
or ordering of valuation measures.
###############################################################################
-/

namespace SigmaR

/--
Relevance does not imply comparability.
-/
axiom relevance_not_comparable :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∀ a s, M₁ a s ≤ M₂ a s ∨ M₂ a s ≤ M₁ a s)

end SigmaR
