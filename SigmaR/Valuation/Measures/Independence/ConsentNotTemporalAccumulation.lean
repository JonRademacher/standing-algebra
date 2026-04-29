import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Standing.ConsentState_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition

/-!
###############################################################################
# Independence: Consent Not Temporal Accumulation
###############################################################################

Consent is a snapshot, agent-level act or expression.
Temporal accumulation tracks irreversible constraint over time.

No default implication from consent to the absence or
prevention of temporal accumulation is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating consent as preventing,
blocking, or licensing the absence of temporal
accumulation is permitted.
-/
axiom consent_not_temporal_accumulation :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsTemporalAccumulationResolvedFromConsentState a s
  )

end SigmaR
