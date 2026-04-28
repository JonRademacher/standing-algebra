import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Capacity
###############################################################################

This file establishes that exit viability does not entail capacity.

Exit viability concerns refusal and non-coercion.
Capacity measures agent ability or potential.

An agent may retain capacity without exit, or have a viable
exit without possessing capacity.

Importing this file explicitly rejects any assumption that
the availability of exit guarantees ability.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to capacity measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_capacity :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → CapacityMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- the option to refuse guarantees ability
- exit substitutes for competence
- non-coercion implies capacity

Exit viability and capacity are distinct structural facts.
-/

