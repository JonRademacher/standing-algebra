import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition

/-!
###############################################################################
# Independence: Consent Not Autonomy
###############################################################################

Consent is an affirmative act or expression.
Autonomy is a structural condition of freedom from coercive constraint.

No default implication from consent to autonomy is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as constituting
or licensing autonomy is permitted.
-/
axiom consent_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromConsentState a s
  )

end SigmaR
