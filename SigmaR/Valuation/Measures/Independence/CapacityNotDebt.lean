import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Capacity ≠ Debt
###############################################################################

This file establishes that capacity measures do not entail
structural debt accumulation.

Capacity expresses potential or ability.
Structural debt tracks accumulated, system-level obligation or constraint.
An agent may lose capacity without incurring debt,
and may incur debt without immediate capacity reduction.

Importing this file explicitly rejects any default assumption that
capacity loss implies indebtedness.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to structural debt.
Any relationship between these quantities must be introduced explicitly.
-/
axiom capacity_not_debt :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → StructuralDebt a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- reduced ability implies obligation
- incapacity can be reinterpreted as debt
- functional limitation licenses structural claims

Capacity and debt are distinct diagnostics.
-/

