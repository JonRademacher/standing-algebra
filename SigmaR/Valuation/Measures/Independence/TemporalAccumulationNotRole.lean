import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Role
###############################################################################

Temporal accumulation does not license or imply institutional
role occupancy.

Temporal accumulation is a structural, time-based diagnostic
of irreversible or narrowing constraint.
Role occupancy is an institutional descriptor of position
or permission.

No default implication from temporal accumulation to role
assignment is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating temporal accumulation as constituting,
assigning, or licensing institutional role occupancy
is permitted.
-/
axiom temporal_accumulation_not_role :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsRoleFromTemporalAccumulation a s
  )

end SigmaR
