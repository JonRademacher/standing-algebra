import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Measurement Absence Does Not Imply Non-Existence
###############################################################################

The absence of measurement or observation does not imply
that a state, property, or condition does not exist.

Measurement limits constrain access, not reality.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from lack of observation to non-existence
is permitted.
-/
axiom measurement_absence_not_nonexistence :
  ¬ (
    ∀ (a : Agent) (s : State),
      ¬ Observable a s → ¬ StateExists s
  )

end SigmaR.Valuation.Measures.MeasurementLimits
