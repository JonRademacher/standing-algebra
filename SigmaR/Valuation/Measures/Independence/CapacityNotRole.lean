import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.RoleState_Definition

/-!
###############################################################################
# Independence: Capacity Not Role
###############################################################################

Role occupancy does not license or imply capacity.
Any relationship between role state and capacity measures
must be introduced explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR

/--
No implication treating role occupancy as implying
or licensing capacity is permitted.
-/
axiom role_not_capacity :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsCapacityFromRoleState a s
  )

end SigmaR
