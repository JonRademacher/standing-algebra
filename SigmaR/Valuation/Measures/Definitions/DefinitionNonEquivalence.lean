import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Definition Non-Equivalence
###############################################################################

Distinct valuation concepts must not be definitionally identical.

This file prevents semantic collapse at the level of primitive
definitions, prior to Independence or WellDefinedness constraints.
###############################################################################
-/

namespace SigmaR

/--
Distinct valuation primitives are not definitionally equal by default.

Any equivalence between distinct concepts must be introduced
explicitly and locally, never implicitly at the definition level.
-/
axiom definition_non_equivalence :
  ∀ (M₁ M₂ : Agent → State → Nat),
    M₁ ≠ M₂

end SigmaR
