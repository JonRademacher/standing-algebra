import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Measurement Silence Does Not Imply Failure
###############################################################################

The absence of measurement signals does not imply
system failure or malfunction.

Silence may result from occlusion or unobservability.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement silence to failure
is permitted.
-/
axiom measurement_silence_not_failure :
  ¬ (
    ∀ (a : Agent) (s : State),
      ¬ Observable a s →
      Failure s
  )

end SigmaR.Valuation.Measures.MeasurementLimits
