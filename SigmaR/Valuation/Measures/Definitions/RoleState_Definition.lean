import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Role State — Definition
###############################################################################

RoleState records whether an agent occupies a role
or permissioned position in a given state.

Source alignment:
• On Relevance: roles never generate standing.
• Standing Algebra (Σᴿ): institutional position
  does not imply authority or legitimacy.

This is a structural descriptor only.
###############################################################################
-/

namespace SigmaR

/--
RoleState a s holds if agent a occupies
a role or permissioned position in state s.
-/
constant RoleState : Agent → State → Prop

end SigmaR
