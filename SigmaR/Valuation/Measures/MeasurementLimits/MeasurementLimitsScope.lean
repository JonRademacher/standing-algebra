import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Measurement Limits Scope
###############################################################################

Measurement limits apply to the act of observation and
diagnosis.

They do not constrain the underlying system state itself.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement limits to constraints
on the system state itself is permitted.
-/
axiom measurement_limits_are_scoped :
  ¬ (
    ∀ (a : Agent) (s : State),
      MeasurementLimited a s →
      ConstrainsState s
  )

end SigmaR.Valuation.Measures.MeasurementLimits
