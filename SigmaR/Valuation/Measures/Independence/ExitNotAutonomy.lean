import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Exit Viability Not Autonomy
###############################################################################

This file establishes that exit viability does not entail autonomy.

Exit viability is a structural predicate concerning the availability
of non-coercive refusal or escape.
Autonomy measures freedom from coercive constraint.

An agent may have a viable exit while autonomy is impaired.

Importing this file explicitly rejects any assumption that
the availability of exit guarantees autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to autonomy measures.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_autonomy :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → AutonomyMeasure a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- the option to leave guarantees freedom
- formal exit substitutes for autonomy
- escape availability negates coercion

Exit viability and autonomy are distinct structural facts.
-/
