import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.MeasurementLimits.ObservabilityIsLocal

/-!
###############################################################################
# Blind Spots Exist
###############################################################################

There exist regions of the state space that are
unobservable by all agents.
###############################################################################
-/

namespace SigmaR

/--
There exists a state that no agent observes.
-/
axiom blind_spots_exist :
  ∃ (s : State),
    ∀ (a : Agent),
      ¬ Observable a s

end SigmaR
