import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Risk Bound Soundness (Valuation Core)
###############################################################################

This file ensures that risk is a bounded, successor-native
valuation quantity.

Risk is NOT aggregated, optimized, or traded.
###############################################################################
-/

namespace SigmaR

/--
Risk load valuation.
-/
constant RiskLoad : Agent → State → Nat

/--
Predicate: operation respects risk bounds.
-/
constant RiskBounded : Operation → Prop

/--
Risk soundness axiom:

Admissible operations respect risk bounds.
-/
axiom AdmissibleRespectsRiskBound :
  ∀ (F : Operation),
    Admissible F →
    RiskBounded F

/--
Derived theorem.
-/
theorem RiskBoundedUnderAdmissible
  (F : Operation)
  (hA : Admissible F) :
  RiskBounded F :=
by
  exact AdmissibleRespectsRiskBound F hA

end SigmaR
