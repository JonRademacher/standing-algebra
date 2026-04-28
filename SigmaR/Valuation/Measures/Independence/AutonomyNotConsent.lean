import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Independence: Autonomy Not Consent
###############################################################################

This file establishes that autonomy does not entail consent.

Although both notions concern agency, autonomy expresses freedom from
coercive constraint, while consent expresses an affirmative act.
No implication between them is assumed at the level of SigmaR.

Importing this file explicitly rejects any default assumption that
autonomy licenses consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy to consent.
Any connection between these predicates must be introduced explicitly.
-/
axiom autonomy_not_consent :
  ¬ (∀ (i : Agent) (s : State),
       Autonomous i s → Consent i s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- lack of coercion implies agreement
- agency implies authorization
- autonomy can substitute for consent

Such assumptions are common but structurally unsafe.
-/
