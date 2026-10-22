import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Role Not Consent
###############################################################################

Institutional role occupancy does not license or imply consent.

Roles describe institutional or permissioned positions.
Consent is an agent-level condition of voluntary participation.

No default implication from role occupancy to consent
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating role occupancy as constituting
or licensing consent is permitted.
-/
axiom role_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromRoleState a s
  )

end SigmaR.Valuation.Measures.Independence
