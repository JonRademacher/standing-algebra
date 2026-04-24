import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissibility Invariant (Valuation Core)
###############################################################################

This file establishes valuation-level invariants preserved
by admissible operations.

This is NOT a legitimacy theorem.
This is NOT a regime constraint.

It only states that admissible operations preserve
the valuation quantities they reference.
###############################################################################
-/

namespace SigmaR

/--
Valuation-level invariant predicate.
-/
constant ValuationInvariant : State → Prop

/--
Admissibility preserves valuation invariants.
-/
axiom AdmissibilityPreservesValuation :
  ∀ (F : Operation) (s : State),
    Admissible F →
    ValuationInvariant s →
    ValuationInvariant (Apply F s)

/--
Derived theorem.
-/
theorem ValuationInvariantUnderAdmissible
  (F : Operation) (s : State)
  (hA : Admissible F)
  (hV : ValuationInvariant s) :
  ValuationInvariant (Apply F s) :=
by
  exact AdmissibilityPreservesValuation F s hA hV

end SigmaR
