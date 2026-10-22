import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.Operation

/-!
###############################################################################
# Debt Coherence (Valuation Core)
###############################################################################

This file defines coherence conditions for structural debt.

Debt is a valuation quantity, not a punishment,
not a legitimacy judgment, and not a market concept.
###############################################################################
-/

namespace SigmaR.Valuation.Core

open SigmaR.Valuation.Measures.Definitions

/--
Structural debt measure.
-/
axiom StructuralDebt : Agent → State → Nat

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

end SigmaR.Valuation.Core
