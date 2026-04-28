import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Capacity Not Exit
###############################################################################

This file establishes that capacity measures do not entail exit viability.

Capacity expresses ability or potential.
Exit viability is a structural predicate concerning refusal,
non-coercion, and the availability of escape.

An agent may possess capacity without a viable exit,
or retain exit viability despite reduced capacity.

Importing this file explicitly rejects any attempt to reduce
exit to agent-level capacity.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from capacity measures
to exit viability.
Any relationship between these concepts must be introduced explicitly.
-/
axiom capacity_not_exit :
  ¬ (∀ (a : Agent) (s : State),
       CapacityMeasure a s → ExitViable a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- ability guarantees escape
- competence implies non-coercion
- exit can be inferred from functional readiness

Exit is structural, not a capacity threshold.
-/

