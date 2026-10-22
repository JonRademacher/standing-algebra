import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Consent Not Autonomy
###############################################################################

Consent is an affirmative act or expression.
Autonomy is a structural condition of freedom from coercive constraint.

No default implication from consent to autonomy is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating consent as constituting
or licensing autonomy is permitted.
-/
axiom consent_not_autonomy :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsAutonomyFromConsentState a s
  )

end SigmaR.Valuation.Measures.Independence
