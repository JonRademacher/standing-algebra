import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.Operation

/-!
###############################################################################
# Temporal Monotonicity (Valuation Core)
###############################################################################

This file ensures that valuation quantities
do not oscillate, reset, or decay without repair.

This blocks "death by a thousand cuts" domination.
###############################################################################
-/

namespace SigmaR.Valuation.Core

open SigmaR.Valuation.Measures.Definitions

/--
Generic valuation quantity over agents and states.
-/
axiom ValuationQty : Agent → State → Nat

/--
Temporal monotonicity axiom:

Valuation quantities may only decrease via repair.
-/
axiom ValuationMonotoneUnlessRepaired :
  ∀ (F : Operation) (i : Agent) (s : State),
    ValuationQty i (Apply F s) < ValuationQty i s →
    Repairs F i

/--
Derived theorem:
No silent valuation decay.
-/
theorem NoValuationDecreaseWithoutRepair
  (F : Operation) (i : Agent) (s : State)
  (h : ValuationQty i (Apply F s) < ValuationQty i s) :
  Repairs F i :=
by
  exact ValuationMonotoneUnlessRepaired F i s h

end SigmaR.Valuation.Core
