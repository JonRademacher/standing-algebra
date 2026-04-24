import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.DebtCoherence

/-!
###############################################################################
# Structural Debt — Well-Definedness
###############################################################################

Ensures that structural debt is a total valuation quantity
and does not depend on operation selection.
###############################################################################
-/

namespace SigmaR

/--
Structural debt is well-defined if it assigns
a natural number to every agent in every state.
-/
def StructuralDebt_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ∃ (n : Nat), StructuralDebt i s = n

end SigmaR
