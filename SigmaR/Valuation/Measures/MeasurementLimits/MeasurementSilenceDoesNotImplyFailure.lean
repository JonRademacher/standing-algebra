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
No implication from measurement silence to failure
is permitted.
-/
axiom measurement_silence_not_failure :
  ¬ (
    ∀ (a : Agent) (s : State),
      ¬ Observable a s →
      Failure s
  )

end SigmaR
