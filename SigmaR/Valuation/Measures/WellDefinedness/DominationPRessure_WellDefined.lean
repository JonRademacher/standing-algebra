import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Domination Pressure — Well-Definedness
###############################################################################

Ensures that domination pressure is a total structural measure
over states.
###############################################################################
-/

namespace SigmaR

/--
Domination pressure is well-defined if it assigns
a natural number to every state.
-/
def DominationPressure_WellDefined : Prop :=
  ∀ (s : State), ∃ (n : Nat), DomPressure s = n

end SigmaR
