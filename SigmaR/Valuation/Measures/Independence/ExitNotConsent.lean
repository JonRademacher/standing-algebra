import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.ExitViability_Definition

/-!
###############################################################################
# Independence: Exit Viability ≠ Consent
###############################################################################

This file establishes that exit viability does not entail consent.

The availability of a viable exit does not imply that participation
was voluntary or uncoerced. Exit and consent are distinct
structural predicates.

Importing this file explicitly rejects any assumption that
the availability of exit guarantees consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from exit viability
to consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom exit_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       ExitViable a → ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- the option to leave implies voluntary participation
- exit availability substitutes for consent
- coercion is negated by formal exit

Exit viability and consent are distinct structural facts.
-/

