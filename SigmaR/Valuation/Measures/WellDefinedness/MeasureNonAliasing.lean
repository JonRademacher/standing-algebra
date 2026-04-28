import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure Non-Aliasing
###############################################################################

Distinct valuation measures must not be definitionally identical
by default. Aliasing collapses semantic distinction.
###############################################################################
-/

namespace SigmaR

/--
Distinct measures are not definitionally identical.
-/
axiom measure_non_aliasing :
  ∀ (M₁ M₂ : Agent → State → Nat),
    M₁ ≠ M₂

end SigmaR
