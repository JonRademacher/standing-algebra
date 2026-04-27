import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Standing.RoleState_Definition

/-!
###############################################################################
# Independence: Exit Viability ≠ Role
###############################################################################

This file establishes that exit viability does not entail
institutional role occupancy.

Exit viability concerns the structural availability of refusal
or escape.
Role occupancy describes an institutional position or permission.

Importing this file explicitly rejects any assumption that
structural exit assigns institutional roles.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to role state.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_role :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → RoleState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- escape availability confers institutional authority
- exit substitutes for role assignment
- refusal capacity collapses into institutional position

Exit viability and role occupancy are distinct structural facts.
-/

