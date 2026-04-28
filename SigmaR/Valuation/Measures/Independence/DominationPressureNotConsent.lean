import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Domination Pressure Not Consent
###############################################################################

This file establishes that domination pressure does not entail
the absence of consent.

Domination pressure is a system-level diagnostic of structural
instability or coercive accumulation.
Consent is an agent-level descriptor of voluntary participation.

Importing this file explicitly rejects any assumption that
systemic domination pressure negates consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from domination pressure
to the absence of consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom domination_pressure_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       DominationPressure s → ¬ ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- systemic domination invalidates agreement
- coercive pressure negates consent by definition
- participation under domination is impossible

Consent and domination pressure are distinct structural facts.
-/

