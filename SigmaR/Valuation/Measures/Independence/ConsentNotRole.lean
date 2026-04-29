import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Consent Not Role
###############################################################################

Consent describes voluntary participation.
Role describes an institutional or permissioned position.

No default implication from consent to role occupancy is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as constituting
or licensing role occupancy is permitted.
-/
axiom consent_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromConsentState a s
  )

end SigmaR
