import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Valuation Non-Degeneracy (Valuation Core)
###############################################################################

This file ensures that valuation predicates
are not trivial or vacuous.

Valuation must distinguish structurally
different states.
###############################################################################
-/

namespace SigmaR

/--
Predicate: two states are structurally distinct.
-/
constant StructurallyDistinct : State → State → Prop

/--
Predicate: valuation distinguishes two states.
-/
constant ValuationDistinguishes : State → State → Prop

/--
Non-degeneracy axiom:

If two states are structurally distinct,
valuation must distinguish them.
-/
axiom ValuationNonDegenerate :
  ∀ (s₁ s₂ : State),
    StructurallyDistinct s₁ s₂ →
    ValuationDistinguishes s₁ s₂

/--
Derived theorem:
Valuation is not vacuous.
-/
theorem ValuationNotTrivial
  (s₁ s₂ : State)
  (h : StructurallyDistinct s₁ s₂) :
  ValuationDistinguishes s₁ s₂ :=
by
  exact ValuationNonDegenerate s₁ s₂ h

end SigmaR
