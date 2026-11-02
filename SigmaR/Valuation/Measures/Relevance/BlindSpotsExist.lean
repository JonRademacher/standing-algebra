import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Relevance.ObservabilityIsLocal

/-!
###############################################################################
# Blind Spots Exist
###############################################################################

There exist regions of the state space that are
unobservable by all agents.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Relevance

open SigmaR.Valuation.Core

/--
There exists a state that no agent observes.
-/
axiom blind_spots_exist :
  ∃ (s : State),
    ∀ (a : Agent),
      ¬ Observable a s

end SigmaR.Valuation.Measures.Relevance
