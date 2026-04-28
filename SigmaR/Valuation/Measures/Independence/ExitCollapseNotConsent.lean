import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitCollapse_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Exit Collapse ≠ Consent
###############################################################################

Exit collapse does not entail absence of consent.

Consent may occur even when structural exit is unavailable,
and exit collapse does not by itself negate voluntariness.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit collapse
to absence of consent.
-/
axiom exit_collapse_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       ExitCollapse a s → ¬ ConsentState a s)

end SigmaR
