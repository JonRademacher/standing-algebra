import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Autonomy (Measure) ≠ Consent
###############################################################################

Autonomy as a structural measure does not entail consent.

An agent may possess autonomy while withholding consent,
and consent may occur under constrained autonomy.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy measures
to consent.
-/
axiom autonomy_not_consent_measure :
  ¬ (∀ (a : Agent) (s : State),
       AutonomyMeasure a s → ConsentState a s)

end SigmaR
