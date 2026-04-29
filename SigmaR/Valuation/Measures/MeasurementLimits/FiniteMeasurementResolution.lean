import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Finite Measurement Resolution
###############################################################################

Measurements have finite resolution.

This file prevents assumptions of arbitrarily fine or
infinitely precise measurement.
###############################################################################
-/

namespace SigmaR

/--
There is no general rule that measurement admits
infinite resolution.

Measurements must not be treated as arbitrarily precise.
-/
axiom no_infinite_measurement_resolution :
  ¬ (
    ∀ (a : Agent) (s : State),
      InfinitelyResolvable (MeasuredValue a s)
  )

end SigmaR
