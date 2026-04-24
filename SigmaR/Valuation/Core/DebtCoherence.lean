import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Debt Coherence (Valuation Core)
###############################################################################

This file defines coherence conditions for structural debt.

Debt is a valuation quantity, not a punishment,
not a legitimacy judgment, and not a market concept.
###############################################################################
-/

namespace SigmaR

/--
Structural debt measure.
-/
constant StructuralDebt : Agent → State → Nat

/--
Predicate: a repair operation applies to agent `i`.
-/
constant Repairs : Operation → Agent → Prop

/--
Debt coherence axioms.

Debt does not disappear without repair.
-/
axiom DebtOnlyReducedByRepair :
  ∀ (F : Operation) (i : Agent) (s : State),
    StructuralDebt i (Apply F s) < StructuralDebt i s →
    Repairs F i

/--
Derived theorem.
-/
theorem NoDebtReductionWithoutRepair
  (F : Operation) (i : Agent) (s : State)
  (h : StructuralDebt i (Apply F s) < StructuralDebt i s) :
  Repairs F i :=
by
  exact DebtOnlyReducedByRepair F i s h

end SigmaR
