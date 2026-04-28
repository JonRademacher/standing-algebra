import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Independence: Consent Not Autonomy
###############################################################################

This file establishes that consent does not entail autonomy.

Consent is an affirmative act or expression.
Autonomy is a structural condition of freedom from coercive constraint.
No implication between these predicates is assumed.

Importing this file explicitly rejects any default assumption that
consent constitutes autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from consent to autonomy.
Any relationship between these predicates must be introduced explicitly.
-/
axiom consent_not_autonomy :
  ¬ (∀ (i : Agent) (s : State),
       Consent i s → Autonomous i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- agreement implies freedom
- consent substitutes for non-coercion
- authorization implies autonomous choice

Consent may occur under constraint.
-/
