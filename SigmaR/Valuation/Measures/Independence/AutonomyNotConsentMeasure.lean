import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ConsentState_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Autonomy (Measure) Not Consent
###############################################################################

Autonomy as a structural valuation measure does not
license or imply consent.

Any relationship between autonomy measures and consent
must be introduced explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating autonomy measures as
licensing or implying consent is permitted.
-/
axiom autonomy_not_consent_measure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsConsentFromAutonomyMeasure a s
  )

end SigmaR.Valuation.Measures.Independence

