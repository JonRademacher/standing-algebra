import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Partial Observability
###############################################################################

Not all aspects of the system are observable
by any agent at any time.

Each agent has blind spots.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
Observability is partial: for every agent, there exist
states that are not observable to that agent.
-/
axiom partial_observability :
  ∀ (a : Agent),
    ∃ (s : State),
      ¬ Observable a s

end SigmaR.Valuation.Measures.MeasurementLimits
