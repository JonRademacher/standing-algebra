import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.RoleState_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Role Not Consent
###############################################################################

This file establishes that institutional role occupancy does not entail consent.

Roles are institutional or permissioned descriptors of position.
Consent is an agent-level condition of voluntary participation.

Importing this file explicitly rejects any assumption that
holding a role constitutes consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from role state
to consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom role_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       RoleState a s → ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- institutional position implies voluntary participation
- permission substitutes for consent
- roles collapse into agreement

Role occupancy and consent are distinct structural facts.
-/

