import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition

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

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
ConsentState is well-defined if it has a determinate
truth value for every agent and state.
-/
def ConsentState_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), ConsentState a s ∨ ¬ ConsentState a s

end SigmaR.Valuation.Measures.WellDefinedness
