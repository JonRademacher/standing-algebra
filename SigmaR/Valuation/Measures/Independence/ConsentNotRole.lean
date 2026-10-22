import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Consent Not Role
###############################################################################

Consent describes voluntary participation.
Role describes an institutional or permissioned position.

No default implication from consent to role occupancy is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating consent as constituting
or licensing role occupancy is permitted.
-/
axiom consent_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromConsentState a s
  )

end SigmaR.Valuation.Measures.Independence
