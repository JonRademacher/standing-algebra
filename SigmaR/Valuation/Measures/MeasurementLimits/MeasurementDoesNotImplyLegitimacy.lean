import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Legitimacy
###############################################################################

The fact that something is measured does not
confer legitimacy, authority, or justification.
###############################################################################
-/

namespace SigmaR

/--
Measurement does not imply legitimacy.
-/
axiom measurement_not_legitimacy :
  ¬ (∀ (a : Agent) (s : State),
        True)

end SigmaR
