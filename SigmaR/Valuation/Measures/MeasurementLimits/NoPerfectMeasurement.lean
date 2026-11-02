import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Perfect Measurement
###############################################################################

No measurement is assumed to perfectly capture
the full state or value of a measure.

Measurement is always epistemically limited.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement to perfect capture
of the system state is permitted.
-/
axiom no_perfect_measurement :
  ¬ (
    ∀ (a : Agent) (s : State),
      Observable a s →
      PerfectMeasurement a s
  )

end SigmaR.Valuation.Measures.MeasurementLimits
