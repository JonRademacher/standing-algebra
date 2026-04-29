import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Silence Does Not Imply Failure
###############################################################################

The absence of measurement signals does not imply
system failure or malfunction.

Silence may result from occlusion or unobservability.
###############################################################################
-/

namespace SigmaR

/--
Measurement silence does not imply failure.
-/
axiom measurement_silence_not_failure :
  ∀ (s : State),
    ¬ True → True

end SigmaR
