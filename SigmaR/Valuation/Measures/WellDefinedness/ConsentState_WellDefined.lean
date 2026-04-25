import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ConsentState_Definition

/-!
###############################################################################
# Consent State — Well-Definedness
###############################################################################

Ensures consent is a total, determinate
structural predicate for all agents and states.

No claims about legitimacy, authority, or admissibility
are made here.
###############################################################################
-/

namespace SigmaR

/--
ConsentState is well-defined if it has a determinate
truth value for every agent and state.
-/
def ConsentState_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), ConsentState a s ∨ ¬ ConsentState a s

end SigmaR
