import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Autonomy Not Consent
###############################################################################

Autonomy expresses freedom from coercive constraint.
Consent expresses an affirmative act.

No default implication from autonomy to consent is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating autonomy as licensing consent
is permitted.
-/
axiom autonomy_not_consent :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromAutonomy a s
  )

end SigmaR.Valuation.Measures.Independence
