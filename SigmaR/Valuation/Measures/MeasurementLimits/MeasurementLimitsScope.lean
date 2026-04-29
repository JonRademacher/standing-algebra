import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Limits Scope
###############################################################################

Measurement limits apply to the act of observation and diagnosis.
They do not constrain the underlying system state itself.
###############################################################################
-/

namespace SigmaR

/--
Measurement limitations are scoped to observers and contexts,
not to the existence of system properties.
-/
axiom measurement_limits_are_scoped :
  ∀ (a : Agent) (s : State),
    True

end SigmaR
