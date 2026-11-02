import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Risk Not Role
###############################################################################

Risk exposure does not license or imply institutional role
occupancy.

Risk load captures exposure to harm or uncertainty.
Role occupancy describes an institutional position or permission.

No default implication from risk exposure to role assignment
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating risk exposure as constituting,
assigning, or licensing institutional role occupancy
is permitted.
-/
axiom risk_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromRiskLoad a s
  )

end SigmaR.Valuation.Measures.Independence
