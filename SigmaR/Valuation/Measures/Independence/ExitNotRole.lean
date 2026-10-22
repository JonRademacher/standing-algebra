import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition
import SigmaR.Valuation.Measures.Definitions.RoleState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Exit Viability Not Role
###############################################################################

Exit viability concerns the structural availability of refusal
or escape.
Role occupancy describes an institutional position or permission.

No default implication from exit viability to role assignment
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating exit viability as constituting,
assigning, or licensing institutional role occupancy
is permitted.
-/
axiom exit_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromExitViable a s
  )

end SigmaR.Valuation.Measures.Independence
