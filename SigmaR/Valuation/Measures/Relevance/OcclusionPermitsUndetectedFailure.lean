import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.ObservabilityIsLocal

/-!
###############################################################################
# Occlusion Permits Undetected Failure
###############################################################################

Occluded regions of the system may contain failures
that are not observable by any agent.
###############################################################################
-/

namespace SigmaR

/--
Abstract notion of failure.
-/
constant Failure : State → Prop

/--
There exist failures that occur in unobservable states.
-/
axiom occlusion_permits_undetected_failure :
  ∃ (s : State),
    Failure s ∧
    ∀ (a : Agent),
      ¬ Observable a s

end SigmaR
