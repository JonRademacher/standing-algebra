import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Independence: Structural Debt ≠ Capacity
###############################################################################

This file establishes that structural debt does not entail capacity.

Structural debt tracks unresolved asymmetry or obligation within
a system.
Capacity measures agent-level ability or potential.

An agent may incur or inherit debt while lacking capacity,
and debt does not license ability.

Importing this file explicitly rejects any assumption that
structural debt implies capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from structural debt
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom debt_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       StructuralDebt a → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- obligation implies ability
- debt substitutes for capacity
- structural asymmetry licenses competence

Debt constrains; it does not empower.
-/

