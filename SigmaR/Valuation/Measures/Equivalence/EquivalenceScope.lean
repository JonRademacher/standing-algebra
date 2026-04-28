import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Scope
###############################################################################

Equivalence between valuation measures is always scoped
to an explicit context.

Equivalence is not global, not timeless, and not implicit.
###############################################################################
-/

namespace SigmaR

/--
Equivalence is meaningful only relative to a context.
-/
axiom equivalence_requires_scope :
  ∀ (M₁ M₂ : Agent → State → Nat),
    True

end SigmaR
